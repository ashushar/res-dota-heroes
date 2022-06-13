const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CopyPlugin = require("copy-webpack-plugin");
const CompressionPlugin = require("compression-webpack-plugin");

module.exports = {
  // mode: "production",
  mode: "development",
  context: __dirname,
  entry: "./src/Home.bs.js",
  output: {
    path: path.resolve(__dirname, "public/build/heroes"),
    publicPath: "/",
    // clean: true,
  },
  devtool: "inline-source-map",
  devServer: {
    static: "src",
    port: 8000,
    historyApiFallback: true,
    open: true,
    hot: true,
  },
  module: {
    rules: [
      // {
      //   test: /\.(png|ico|jp(e*)g|webp|svg)$/,
      //   use: [
      //     {
      //       loader: "url-loader",
      //       options: {
      //         limit: 8000,
      //       },
      //     },
      //   ],
      // },
      {
        test: /\.(png|ico|jpe?g|gif)$/i,
        type: "asset/resource",
        // loader: "file-loader",
        // options: {
        //   name: "[name].[ext]",
        // },
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      filename: "index.html",
      template: "index.html",
    }),
    new CompressionPlugin(),

    new CopyPlugin({
      patterns: [
        {
          from: path.resolve(__dirname, "./src/ServiceWorkerInst.bs.js"),
          to: "./ServiceWorkerInst.bs.js",
        },
        {
          from: path.resolve(__dirname, "./manifest.json"),
          to: "./manifest.json",
        },
      ],
    }),
  ],
};
