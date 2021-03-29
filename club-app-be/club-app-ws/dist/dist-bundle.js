/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./src/conn_dconn.ts":
/*!***************************!*\
  !*** ./src/conn_dconn.ts ***!
  \***************************/
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.disconnect = exports.connect = void 0;
const axios_1 = __importDefault(__webpack_require__(/*! axios */ "axios"));
const connect = async ({ id }) => {
    await axios_1.default.post("http://localhost:8787/gateway/connect/", {
        id: id
    });
    return { statusCode: 200 };
};
exports.connect = connect;
const disconnect = async ({ id }) => {
    console.log('disconnect %s', id);
    return { statusCode: 200 };
};
exports.disconnect = disconnect;


/***/ }),

/***/ "./src/default.ts":
/*!************************!*\
  !*** ./src/default.ts ***!
  \************************/
/***/ ((__unused_webpack_module, exports) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.r_default = void 0;
const r_default = async ({ id, route }) => {
    console.log('default message', route, id);
    return { statusCode: 200 };
};
exports.r_default = r_default;


/***/ }),

/***/ "./src/main.ts":
/*!*********************!*\
  !*** ./src/main.ts ***!
  \*********************/
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.handler = void 0;
const aws_lambda_ws_server_1 = __importDefault(__webpack_require__(/*! aws-lambda-ws-server */ "aws-lambda-ws-server"));
const conn_dconn_1 = __webpack_require__(/*! ./conn_dconn */ "./src/conn_dconn.ts");
const default_1 = __webpack_require__(/*! ./default */ "./src/default.ts");
exports.handler = aws_lambda_ws_server_1.default(aws_lambda_ws_server_1.default.handler({
    connect: conn_dconn_1.connect,
    disconnect: conn_dconn_1.disconnect,
    default: default_1.r_default
}));


/***/ }),

/***/ "aws-lambda-ws-server":
/*!***************************************!*\
  !*** external "aws-lambda-ws-server" ***!
  \***************************************/
/***/ ((module) => {

module.exports = require("aws-lambda-ws-server");;

/***/ }),

/***/ "axios":
/*!************************!*\
  !*** external "axios" ***!
  \************************/
/***/ ((module) => {

module.exports = require("axios");;

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module is referenced by other modules so it can't be inlined
/******/ 	var __webpack_exports__ = __webpack_require__("./src/main.ts");
/******/ 	
/******/ })()
;
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9jbHViLWFwcC13cy8uL3NyYy9jb25uX2Rjb25uLnRzIiwid2VicGFjazovL2NsdWItYXBwLXdzLy4vc3JjL2RlZmF1bHQudHMiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvLi9zcmMvbWFpbi50cyIsIndlYnBhY2s6Ly9jbHViLWFwcC13cy9leHRlcm5hbCBcImF3cy1sYW1iZGEtd3Mtc2VydmVyXCIiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvZXh0ZXJuYWwgXCJheGlvc1wiIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svYm9vdHN0cmFwIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svc3RhcnR1cCJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOzs7Ozs7Ozs7O0FBQWE7QUFDYjtBQUNBLDRDQUE0QztBQUM1QztBQUNBLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxrQkFBa0IsR0FBRyxlQUFlO0FBQ3BDLGdDQUFnQyxtQkFBTyxDQUFDLG9CQUFPO0FBQy9DLHdCQUF3QixLQUFLO0FBQzdCO0FBQ0E7QUFDQSxLQUFLO0FBQ0wsWUFBWTtBQUNaO0FBQ0EsZUFBZTtBQUNmLDJCQUEyQixLQUFLO0FBQ2hDO0FBQ0EsWUFBWTtBQUNaO0FBQ0Esa0JBQWtCOzs7Ozs7Ozs7OztBQ2xCTDtBQUNiLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxpQkFBaUI7QUFDakIsMEJBQTBCLFlBQVk7QUFDdEM7QUFDQSxZQUFZO0FBQ1o7QUFDQSxpQkFBaUI7Ozs7Ozs7Ozs7O0FDUEo7QUFDYjtBQUNBLDRDQUE0QztBQUM1QztBQUNBLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxlQUFlO0FBQ2YsK0NBQStDLG1CQUFPLENBQUMsa0RBQXNCO0FBQzdFLHFCQUFxQixtQkFBTyxDQUFDLHlDQUFjO0FBQzNDLGtCQUFrQixtQkFBTyxDQUFDLG1DQUFXO0FBQ3JDLGVBQWU7QUFDZjtBQUNBO0FBQ0E7QUFDQSxDQUFDOzs7Ozs7Ozs7OztBQ2JELGtEOzs7Ozs7Ozs7O0FDQUEsbUM7Ozs7OztVQ0FBO1VBQ0E7O1VBRUE7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7O1VBRUE7VUFDQTs7VUFFQTtVQUNBO1VBQ0E7Ozs7VUN0QkE7VUFDQTtVQUNBO1VBQ0EiLCJmaWxlIjoiZGlzdC1idW5kbGUuanMiLCJzb3VyY2VzQ29udGVudCI6WyJcInVzZSBzdHJpY3RcIjtcbnZhciBfX2ltcG9ydERlZmF1bHQgPSAodGhpcyAmJiB0aGlzLl9faW1wb3J0RGVmYXVsdCkgfHwgZnVuY3Rpb24gKG1vZCkge1xuICAgIHJldHVybiAobW9kICYmIG1vZC5fX2VzTW9kdWxlKSA/IG1vZCA6IHsgXCJkZWZhdWx0XCI6IG1vZCB9O1xufTtcbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCBcIl9fZXNNb2R1bGVcIiwgeyB2YWx1ZTogdHJ1ZSB9KTtcbmV4cG9ydHMuZGlzY29ubmVjdCA9IGV4cG9ydHMuY29ubmVjdCA9IHZvaWQgMDtcbmNvbnN0IGF4aW9zXzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcImF4aW9zXCIpKTtcbmNvbnN0IGNvbm5lY3QgPSBhc3luYyAoeyBpZCB9KSA9PiB7XG4gICAgYXdhaXQgYXhpb3NfMS5kZWZhdWx0LnBvc3QoXCJodHRwOi8vbG9jYWxob3N0Ojg3ODcvZ2F0ZXdheS9jb25uZWN0L1wiLCB7XG4gICAgICAgIGlkOiBpZFxuICAgIH0pO1xuICAgIHJldHVybiB7IHN0YXR1c0NvZGU6IDIwMCB9O1xufTtcbmV4cG9ydHMuY29ubmVjdCA9IGNvbm5lY3Q7XG5jb25zdCBkaXNjb25uZWN0ID0gYXN5bmMgKHsgaWQgfSkgPT4ge1xuICAgIGNvbnNvbGUubG9nKCdkaXNjb25uZWN0ICVzJywgaWQpO1xuICAgIHJldHVybiB7IHN0YXR1c0NvZGU6IDIwMCB9O1xufTtcbmV4cG9ydHMuZGlzY29ubmVjdCA9IGRpc2Nvbm5lY3Q7XG4iLCJcInVzZSBzdHJpY3RcIjtcbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCBcIl9fZXNNb2R1bGVcIiwgeyB2YWx1ZTogdHJ1ZSB9KTtcbmV4cG9ydHMucl9kZWZhdWx0ID0gdm9pZCAwO1xuY29uc3Qgcl9kZWZhdWx0ID0gYXN5bmMgKHsgaWQsIHJvdXRlIH0pID0+IHtcbiAgICBjb25zb2xlLmxvZygnZGVmYXVsdCBtZXNzYWdlJywgcm91dGUsIGlkKTtcbiAgICByZXR1cm4geyBzdGF0dXNDb2RlOiAyMDAgfTtcbn07XG5leHBvcnRzLnJfZGVmYXVsdCA9IHJfZGVmYXVsdDtcbiIsIlwidXNlIHN0cmljdFwiO1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5oYW5kbGVyID0gdm9pZCAwO1xuY29uc3QgYXdzX2xhbWJkYV93c19zZXJ2ZXJfMSA9IF9faW1wb3J0RGVmYXVsdChyZXF1aXJlKFwiYXdzLWxhbWJkYS13cy1zZXJ2ZXJcIikpO1xuY29uc3QgY29ubl9kY29ubl8xID0gcmVxdWlyZShcIi4vY29ubl9kY29ublwiKTtcbmNvbnN0IGRlZmF1bHRfMSA9IHJlcXVpcmUoXCIuL2RlZmF1bHRcIik7XG5leHBvcnRzLmhhbmRsZXIgPSBhd3NfbGFtYmRhX3dzX3NlcnZlcl8xLmRlZmF1bHQoYXdzX2xhbWJkYV93c19zZXJ2ZXJfMS5kZWZhdWx0LmhhbmRsZXIoe1xuICAgIGNvbm5lY3Q6IGNvbm5fZGNvbm5fMS5jb25uZWN0LFxuICAgIGRpc2Nvbm5lY3Q6IGNvbm5fZGNvbm5fMS5kaXNjb25uZWN0LFxuICAgIGRlZmF1bHQ6IGRlZmF1bHRfMS5yX2RlZmF1bHRcbn0pKTtcbiIsIm1vZHVsZS5leHBvcnRzID0gcmVxdWlyZShcImF3cy1sYW1iZGEtd3Mtc2VydmVyXCIpOzsiLCJtb2R1bGUuZXhwb3J0cyA9IHJlcXVpcmUoXCJheGlvc1wiKTs7IiwiLy8gVGhlIG1vZHVsZSBjYWNoZVxudmFyIF9fd2VicGFja19tb2R1bGVfY2FjaGVfXyA9IHt9O1xuXG4vLyBUaGUgcmVxdWlyZSBmdW5jdGlvblxuZnVuY3Rpb24gX193ZWJwYWNrX3JlcXVpcmVfXyhtb2R1bGVJZCkge1xuXHQvLyBDaGVjayBpZiBtb2R1bGUgaXMgaW4gY2FjaGVcblx0dmFyIGNhY2hlZE1vZHVsZSA9IF9fd2VicGFja19tb2R1bGVfY2FjaGVfX1ttb2R1bGVJZF07XG5cdGlmIChjYWNoZWRNb2R1bGUgIT09IHVuZGVmaW5lZCkge1xuXHRcdHJldHVybiBjYWNoZWRNb2R1bGUuZXhwb3J0cztcblx0fVxuXHQvLyBDcmVhdGUgYSBuZXcgbW9kdWxlIChhbmQgcHV0IGl0IGludG8gdGhlIGNhY2hlKVxuXHR2YXIgbW9kdWxlID0gX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fW21vZHVsZUlkXSA9IHtcblx0XHQvLyBubyBtb2R1bGUuaWQgbmVlZGVkXG5cdFx0Ly8gbm8gbW9kdWxlLmxvYWRlZCBuZWVkZWRcblx0XHRleHBvcnRzOiB7fVxuXHR9O1xuXG5cdC8vIEV4ZWN1dGUgdGhlIG1vZHVsZSBmdW5jdGlvblxuXHRfX3dlYnBhY2tfbW9kdWxlc19fW21vZHVsZUlkXS5jYWxsKG1vZHVsZS5leHBvcnRzLCBtb2R1bGUsIG1vZHVsZS5leHBvcnRzLCBfX3dlYnBhY2tfcmVxdWlyZV9fKTtcblxuXHQvLyBSZXR1cm4gdGhlIGV4cG9ydHMgb2YgdGhlIG1vZHVsZVxuXHRyZXR1cm4gbW9kdWxlLmV4cG9ydHM7XG59XG5cbiIsIi8vIHN0YXJ0dXBcbi8vIExvYWQgZW50cnkgbW9kdWxlIGFuZCByZXR1cm4gZXhwb3J0c1xuLy8gVGhpcyBlbnRyeSBtb2R1bGUgaXMgcmVmZXJlbmNlZCBieSBvdGhlciBtb2R1bGVzIHNvIGl0IGNhbid0IGJlIGlubGluZWRcbnZhciBfX3dlYnBhY2tfZXhwb3J0c19fID0gX193ZWJwYWNrX3JlcXVpcmVfXyhcIi4vc3JjL21haW4udHNcIik7XG4iXSwic291cmNlUm9vdCI6IiJ9