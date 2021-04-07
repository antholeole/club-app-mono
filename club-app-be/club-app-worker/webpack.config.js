 /* eslint-disable */

const path = require('path')
const webpack = require('webpack')
const TerserPlugin = require("terser-webpack-plugin")

const mode = process.env.NODE_ENV || 'production'

module.exports = {
  output: {
    filename: `worker.js`,
    path: path.join(__dirname, 'dist'),
  },
  mode,
  resolve: {
    extensions: ['.ts', '.tsx', '.js'],
    plugins: [],
  },
  optimization: {
    usedExports: true,
minimize: true,
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
