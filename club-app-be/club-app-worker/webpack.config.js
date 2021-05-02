/* eslint-disable */

const path = require('path')
const webpack = require('webpack')
const TerserPlugin = require("terser-webpack-plugin")
const fs = require('fs')

const mode = 'production'

let plugins = []


function getDotEnvVariable(variable) {
  let read = JSON.stringify(
    fs.readFileSync('../../.env', 'utf-8').split('\n')
    .find((v) => v.includes(`${variable}=`))
    .split(`${variable}=`)[1])

    return read
}

if (process.env.NODE_ENV === 'development') {
  const hasuraPassword = getDotEnvVariable('ADMIN_SECRET')
  const jwtSecret = getDotEnvVariable('JWT_SECRET')

  plugins.push(
    new webpack.DefinePlugin({
      ENVIRONMENT: JSON.stringify('dev'),
      HASURA_PASSWORD: hasuraPassword,
      SECRET: jwtSecret
    })
  )
}

module.exports = {
  output: {
    filename: `worker.js`,
    path: path.join(__dirname, 'dist'),
  },
  mode,
  resolve: {
    extensions: ['.ts', '.tsx', '.js'],
  },
  plugins: plugins,
  optimization: {
    usedExports: process.env.NODE_ENV !== 'development',
    minimize: process.env.NODE_ENV !== 'development',
    minimizer: [
      new TerserPlugin()
    ]
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        loader: 'ts-loader',
        options: {
          transpileOnly: true,
        },
      },
    ],
  },
}
