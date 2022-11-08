var products = require("./data/products.json");
var users = require("./data/users.json");

module.exports = function () {
  return {
    products,
    users,
  };
};
