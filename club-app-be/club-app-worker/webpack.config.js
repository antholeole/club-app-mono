/* eslint-disable */

const path = require('path')
const webpack = require('webpack')
const TerserPlugin = require("terser-webpack-plugin")
const fs = require('fs')

const mode = 'production'

let plugins = []

if (process.env.NODE_ENV === 'development') {
  //naieve .env lookup
  const hasura_password = JSON.stringify(
    fs.readFileSync('.env', 'utf-8').split('\n')
    .find((v) => v.includes('HASURA_PASSWORD='))
    .split('HASURA_PASSWORD=')[1])

  plugins.push(
    new webpack.DefinePlugin({
      ENVIRONMENT: JSON.stringify('dev'),
      HASURA_PASSWORD: hasura_password,
      SECRET: JSON.stringify('LOL NOT REAL SECRET')
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
