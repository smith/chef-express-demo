require("express")().get('/', function (req, res) {
  res.send("Hello World!")
}).listen(process.env.PORT || 3000);
