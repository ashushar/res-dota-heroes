const express = require("express");
const expressStaticGzip = require("express-static-gzip");
const path = require("path");

const port = 8000;
const app = express();
const publicPath = path.join(__dirname, "public", "build");
app.use(
  expressStaticGzip(publicPath, {
    serveStatic: {
      maxAge: 315360000000,
      cacheControl: true,
    },
  })
);
app.use(express.json());

app.use("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "build", "heroes", "index.html"));
});

app.listen(port, () => console.log(`Started on port ${port}`));
