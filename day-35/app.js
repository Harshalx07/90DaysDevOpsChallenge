const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("Hello from Multi-Stage Build");
});

app.listen(3000, () => {
  console.log("Server running");
});