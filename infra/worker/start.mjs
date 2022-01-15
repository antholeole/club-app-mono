import { Miniflare } from 'miniflare'
import { readdirSync } from 'fs'
import path from 'path'

const config = {
  kvNamespaces: ['PUBLIC_KEYS', 'REFRESH_TOKENS', 'DEVICE_TOKENS'],
  bindings: {
    ENVIRONMENT: 'dev',
    HASURA_PASSWORD: process.env.ADMIN_SECRET,
    HASURA_ENDPOINT: 'http://hasura:8080/v1/graphql',
    SECRET: process.env.JWT_SECRET,
    WEBHOOK_SECRET_KEY: process.env.WEBHOOK_SECRET_KEY,
    B2_ACCESS_KEY_ID: 'accessKeyId',
    B2_SECRET_ACCESS_KEY: 'screcretAccessKey'
  },
}

function generateApiRoutes(route) {
  const routes = []
  const routeAsRoute = path.join(...route)
  for (const extension of ['/', '']) {
    routes.push('*/api/' + routeAsRoute + extension)
  }

  return routes
}
//MiniflareOptions['mounts']
function getIOPaths(routerFolderPath, dir = []) {
  let result = {}
  const filesInPath = readdirSync(path.join(routerFolderPath, ...dir), { withFileTypes: true })

  for (const file of filesInPath) {
    if (file.isDirectory()) {
      result = { ...result, ...getIOPaths(routerFolderPath, [...dir, file.name]) }
    } else if (file.name === 'index.js') {
      result[dir[dir.length - 1]] = {
        ...config,
        kvPersist: true,
        rootPath: './' + path.join(routerFolderPath, ...dir),
        scriptPath: './index.js',
        routes: generateApiRoutes(dir)
      }
    }
  }


  return result
}


const mf = new Miniflare({
  ...config,
  port: 8787,
  sourceMap: true,
  logUnhandledRejections: true,
  kvPersist: true,
  script: `
  addEventListener("fetch", (event) => {
    event.respondWith(new Response('{"message": "404 not found"}', {
        status: 404
    }));
});
  `,
  mounts: getIOPaths(path.join('./', 'dist'))
})


mf.startServer().then(() => console.info('started server!'))

