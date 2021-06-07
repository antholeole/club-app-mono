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
const connect = async (msg) => {
    await axios_1.default.post("http://localhost:8787/api/gateway/connect/", msg);
    return { statusCode: 200 };
};
exports.connect = connect;
const disconnect = async (msg) => {
    await axios_1.default.post("http://localhost:8787/api/gateway/disconnect/", msg);
    return { statusCode: 200 };
};
exports.disconnect = disconnect;


/***/ }),

/***/ "./src/default.ts":
/*!************************!*\
  !*** ./src/default.ts ***!
  \************************/
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.r_default = void 0;
const axios_1 = __importDefault(__webpack_require__(/*! axios */ "axios"));
const r_default = async (msg) => {
    await axios_1.default.post("http://localhost:8787/api/gateway/message/", msg);
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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9jbHViLWFwcC13cy8uL3NyYy9jb25uX2Rjb25uLnRzIiwid2VicGFjazovL2NsdWItYXBwLXdzLy4vc3JjL2RlZmF1bHQudHMiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvLi9zcmMvbWFpbi50cyIsIndlYnBhY2s6Ly9jbHViLWFwcC13cy9leHRlcm5hbCBcImF3cy1sYW1iZGEtd3Mtc2VydmVyXCIiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvZXh0ZXJuYWwgXCJheGlvc1wiIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svYm9vdHN0cmFwIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svc3RhcnR1cCJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOzs7Ozs7Ozs7O0FBQWE7QUFDYjtBQUNBLDRDQUE0QztBQUM1QztBQUNBLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxrQkFBa0IsR0FBRyxlQUFlO0FBQ3BDLGdDQUFnQyxtQkFBTyxDQUFDLG9CQUFPO0FBQy9DO0FBQ0E7QUFDQSxZQUFZO0FBQ1o7QUFDQSxlQUFlO0FBQ2Y7QUFDQTtBQUNBLFlBQVk7QUFDWjtBQUNBLGtCQUFrQjs7Ozs7Ozs7Ozs7QUNoQkw7QUFDYjtBQUNBLDRDQUE0QztBQUM1QztBQUNBLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxpQkFBaUI7QUFDakIsZ0NBQWdDLG1CQUFPLENBQUMsb0JBQU87QUFDL0M7QUFDQTtBQUNBLFlBQVk7QUFDWjtBQUNBLGlCQUFpQjs7Ozs7Ozs7Ozs7QUNYSjtBQUNiO0FBQ0EsNENBQTRDO0FBQzVDO0FBQ0EsOENBQTZDLENBQUMsY0FBYyxFQUFDO0FBQzdELGVBQWU7QUFDZiwrQ0FBK0MsbUJBQU8sQ0FBQyxrREFBc0I7QUFDN0UscUJBQXFCLG1CQUFPLENBQUMseUNBQWM7QUFDM0Msa0JBQWtCLG1CQUFPLENBQUMsbUNBQVc7QUFDckMsZUFBZTtBQUNmO0FBQ0E7QUFDQTtBQUNBLENBQUM7Ozs7Ozs7Ozs7O0FDYkQsa0Q7Ozs7Ozs7Ozs7QUNBQSxtQzs7Ozs7O1VDQUE7VUFDQTs7VUFFQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTs7VUFFQTtVQUNBOztVQUVBO1VBQ0E7VUFDQTs7OztVQ3RCQTtVQUNBO1VBQ0E7VUFDQSIsImZpbGUiOiJkaXN0LWJ1bmRsZS5qcyIsInNvdXJjZXNDb250ZW50IjpbIlwidXNlIHN0cmljdFwiO1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5kaXNjb25uZWN0ID0gZXhwb3J0cy5jb25uZWN0ID0gdm9pZCAwO1xuY29uc3QgYXhpb3NfMSA9IF9faW1wb3J0RGVmYXVsdChyZXF1aXJlKFwiYXhpb3NcIikpO1xuY29uc3QgY29ubmVjdCA9IGFzeW5jIChtc2cpID0+IHtcbiAgICBhd2FpdCBheGlvc18xLmRlZmF1bHQucG9zdChcImh0dHA6Ly9sb2NhbGhvc3Q6ODc4Ny9hcGkvZ2F0ZXdheS9jb25uZWN0L1wiLCBtc2cpO1xuICAgIHJldHVybiB7IHN0YXR1c0NvZGU6IDIwMCB9O1xufTtcbmV4cG9ydHMuY29ubmVjdCA9IGNvbm5lY3Q7XG5jb25zdCBkaXNjb25uZWN0ID0gYXN5bmMgKG1zZykgPT4ge1xuICAgIGF3YWl0IGF4aW9zXzEuZGVmYXVsdC5wb3N0KFwiaHR0cDovL2xvY2FsaG9zdDo4Nzg3L2FwaS9nYXRld2F5L2Rpc2Nvbm5lY3QvXCIsIG1zZyk7XG4gICAgcmV0dXJuIHsgc3RhdHVzQ29kZTogMjAwIH07XG59O1xuZXhwb3J0cy5kaXNjb25uZWN0ID0gZGlzY29ubmVjdDtcbiIsIlwidXNlIHN0cmljdFwiO1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5yX2RlZmF1bHQgPSB2b2lkIDA7XG5jb25zdCBheGlvc18xID0gX19pbXBvcnREZWZhdWx0KHJlcXVpcmUoXCJheGlvc1wiKSk7XG5jb25zdCByX2RlZmF1bHQgPSBhc3luYyAobXNnKSA9PiB7XG4gICAgYXdhaXQgYXhpb3NfMS5kZWZhdWx0LnBvc3QoXCJodHRwOi8vbG9jYWxob3N0Ojg3ODcvYXBpL2dhdGV3YXkvbWVzc2FnZS9cIiwgbXNnKTtcbiAgICByZXR1cm4geyBzdGF0dXNDb2RlOiAyMDAgfTtcbn07XG5leHBvcnRzLnJfZGVmYXVsdCA9IHJfZGVmYXVsdDtcbiIsIlwidXNlIHN0cmljdFwiO1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5oYW5kbGVyID0gdm9pZCAwO1xuY29uc3QgYXdzX2xhbWJkYV93c19zZXJ2ZXJfMSA9IF9faW1wb3J0RGVmYXVsdChyZXF1aXJlKFwiYXdzLWxhbWJkYS13cy1zZXJ2ZXJcIikpO1xuY29uc3QgY29ubl9kY29ubl8xID0gcmVxdWlyZShcIi4vY29ubl9kY29ublwiKTtcbmNvbnN0IGRlZmF1bHRfMSA9IHJlcXVpcmUoXCIuL2RlZmF1bHRcIik7XG5leHBvcnRzLmhhbmRsZXIgPSBhd3NfbGFtYmRhX3dzX3NlcnZlcl8xLmRlZmF1bHQoYXdzX2xhbWJkYV93c19zZXJ2ZXJfMS5kZWZhdWx0LmhhbmRsZXIoe1xuICAgIGNvbm5lY3Q6IGNvbm5fZGNvbm5fMS5jb25uZWN0LFxuICAgIGRpc2Nvbm5lY3Q6IGNvbm5fZGNvbm5fMS5kaXNjb25uZWN0LFxuICAgIGRlZmF1bHQ6IGRlZmF1bHRfMS5yX2RlZmF1bHRcbn0pKTtcbiIsIm1vZHVsZS5leHBvcnRzID0gcmVxdWlyZShcImF3cy1sYW1iZGEtd3Mtc2VydmVyXCIpOzsiLCJtb2R1bGUuZXhwb3J0cyA9IHJlcXVpcmUoXCJheGlvc1wiKTs7IiwiLy8gVGhlIG1vZHVsZSBjYWNoZVxudmFyIF9fd2VicGFja19tb2R1bGVfY2FjaGVfXyA9IHt9O1xuXG4vLyBUaGUgcmVxdWlyZSBmdW5jdGlvblxuZnVuY3Rpb24gX193ZWJwYWNrX3JlcXVpcmVfXyhtb2R1bGVJZCkge1xuXHQvLyBDaGVjayBpZiBtb2R1bGUgaXMgaW4gY2FjaGVcblx0dmFyIGNhY2hlZE1vZHVsZSA9IF9fd2VicGFja19tb2R1bGVfY2FjaGVfX1ttb2R1bGVJZF07XG5cdGlmIChjYWNoZWRNb2R1bGUgIT09IHVuZGVmaW5lZCkge1xuXHRcdHJldHVybiBjYWNoZWRNb2R1bGUuZXhwb3J0cztcblx0fVxuXHQvLyBDcmVhdGUgYSBuZXcgbW9kdWxlIChhbmQgcHV0IGl0IGludG8gdGhlIGNhY2hlKVxuXHR2YXIgbW9kdWxlID0gX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fW21vZHVsZUlkXSA9IHtcblx0XHQvLyBubyBtb2R1bGUuaWQgbmVlZGVkXG5cdFx0Ly8gbm8gbW9kdWxlLmxvYWRlZCBuZWVkZWRcblx0XHRleHBvcnRzOiB7fVxuXHR9O1xuXG5cdC8vIEV4ZWN1dGUgdGhlIG1vZHVsZSBmdW5jdGlvblxuXHRfX3dlYnBhY2tfbW9kdWxlc19fW21vZHVsZUlkXS5jYWxsKG1vZHVsZS5leHBvcnRzLCBtb2R1bGUsIG1vZHVsZS5leHBvcnRzLCBfX3dlYnBhY2tfcmVxdWlyZV9fKTtcblxuXHQvLyBSZXR1cm4gdGhlIGV4cG9ydHMgb2YgdGhlIG1vZHVsZVxuXHRyZXR1cm4gbW9kdWxlLmV4cG9ydHM7XG59XG5cbiIsIi8vIHN0YXJ0dXBcbi8vIExvYWQgZW50cnkgbW9kdWxlIGFuZCByZXR1cm4gZXhwb3J0c1xuLy8gVGhpcyBlbnRyeSBtb2R1bGUgaXMgcmVmZXJlbmNlZCBieSBvdGhlciBtb2R1bGVzIHNvIGl0IGNhbid0IGJlIGlubGluZWRcbnZhciBfX3dlYnBhY2tfZXhwb3J0c19fID0gX193ZWJwYWNrX3JlcXVpcmVfXyhcIi4vc3JjL21haW4udHNcIik7XG4iXSwic291cmNlUm9vdCI6IiJ9