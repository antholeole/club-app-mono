import path, { resolve } from 'path'
import { Configuration, WebpackPluginInstance } from 'webpack'
import { CleanWebpackPlugin } from 'clean-webpack-plugin'
import { ESBuildMinifyPlugin } from 'esbuild-loader'
import { readdirSync } from 'fs'

const mode = 'production'

function getIOFiles(routerFolderPath: string, dir: string[] = []): Record<string, string> {
  let result: Record<string, string> = {}
  const filesInPath = readdirSync(path.join(routerFolderPath, ...dir), { withFileTypes: true })

  for (const file of filesInPath) {
    if (file.isDirectory()) {
      result = { ...result, ...getIOFiles(routerFolderPath, [...dir, file.name]) }
    } else if (file.name === 'index.ts') {
      const indexFile = path.join(...dir, 'index.ts')
      result[path.join(...dir)] = indexFile
    }
  }

  if (!dir.length) {
    for (const key of Object.keys(result)) {
      result[key] = path.join(routerFolderPath, result[key])
    }
  }

  return result
}


const plugins: WebpackPluginInstance[] = [new CleanWebpackPlugin(),]
let sourceMap = undefined
if (process.env.NODE_ENV === 'development') {
  sourceMap = 'source-map'
}




const ONE_MB = 1000000
const config: Configuration = {
  target: 'webworker',
  performance: {
    hints: process.env.NODE_ENV === 'development' ? false : 'error',
    maxAssetSize: ONE_MB,
    maxEntrypointSize: ONE_MB
  },
  entry: getIOFiles(path.join(__dirname, 'src', 'routers')),
  output: {
    filename: '[name]/index.js',
    path: resolve(__dirname, 'dist')
  },
  devtool: sourceMap,
  mode,
  resolve: {
    extensions: ['.ts', '.tsx', '.js']
  },
  plugins: plugins,
  optimization: {
    usedExports: process.env.NODE_ENV !== 'development',
    minimize: process.env.NODE_ENV !== 'development',
    minimizer: [
      new ESBuildMinifyPlugin()
    ]
  },
  module: {
    rules: [
      {
        test: /\.ts?$/,
        loader: 'esbuild-loader',
        options: {
          loader: 'ts',
          target: 'es2015'
        }
      },
    ],
  },
  stats: 'errors-only'
}

export default config
