const path = require('path');
const nodeExternals = require('webpack-node-externals');
const NodemonPlugin = require('nodemon-webpack-plugin');

module.exports = {
  mode: "development",
  devtool: "inline-source-map",
  target: "node",
  externals: [nodeExternals()],
  plugins: [
      new NodemonPlugin()
  ],
  entry: {
    main: "./src/main.ts",
  },
  output: {
    path: path.resolve(__dirname, './dist'),
    filename: "dist-bundle.js"
  },
  resolve: {
    extensions: [".ts", ".tsx", ".js"],
  },
  module: {
    rules: [
      { 
        test: /\.tsx?$/,
        loader: "ts-loader"
      }
    ]
  }
};
