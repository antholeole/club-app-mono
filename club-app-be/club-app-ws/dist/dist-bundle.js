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
    await axios_1.default.post("http://localhost:8787/api/gateway/message", msg);
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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9jbHViLWFwcC13cy8uL3NyYy9jb25uX2Rjb25uLnRzIiwid2VicGFjazovL2NsdWItYXBwLXdzLy4vc3JjL2RlZmF1bHQudHMiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvLi9zcmMvbWFpbi50cyIsIndlYnBhY2s6Ly9jbHViLWFwcC13cy9leHRlcm5hbCBcImF3cy1sYW1iZGEtd3Mtc2VydmVyXCIiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvZXh0ZXJuYWwgXCJheGlvc1wiIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svYm9vdHN0cmFwIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svc3RhcnR1cCJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOzs7Ozs7Ozs7O0FBQWE7QUFDYjtBQUNBLDRDQUE0QztBQUM1QztBQUNBLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxrQkFBa0IsR0FBRyxlQUFlO0FBQ3BDLGdDQUFnQyxtQkFBTyxDQUFDLG9CQUFPO0FBQy9DO0FBQ0E7QUFDQSxZQUFZO0FBQ1o7QUFDQSxlQUFlO0FBQ2Y7QUFDQTtBQUNBLFlBQVk7QUFDWjtBQUNBLGtCQUFrQjs7Ozs7Ozs7Ozs7QUNoQkw7QUFDYjtBQUNBLDRDQUE0QztBQUM1QztBQUNBLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxpQkFBaUI7QUFDakIsZ0NBQWdDLG1CQUFPLENBQUMsb0JBQU87QUFDL0M7QUFDQTtBQUNBLFlBQVk7QUFDWjtBQUNBLGlCQUFpQjs7Ozs7Ozs7Ozs7QUNYSjtBQUNiO0FBQ0EsNENBQTRDO0FBQzVDO0FBQ0EsOENBQTZDLENBQUMsY0FBYyxFQUFDO0FBQzdELGVBQWU7QUFDZiwrQ0FBK0MsbUJBQU8sQ0FBQyxrREFBc0I7QUFDN0UscUJBQXFCLG1CQUFPLENBQUMseUNBQWM7QUFDM0Msa0JBQWtCLG1CQUFPLENBQUMsbUNBQVc7QUFDckMsZUFBZTtBQUNmO0FBQ0E7QUFDQTtBQUNBLENBQUM7Ozs7Ozs7Ozs7O0FDYkQsa0Q7Ozs7Ozs7Ozs7QUNBQSxtQzs7Ozs7O1VDQUE7VUFDQTs7VUFFQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTs7VUFFQTtVQUNBOztVQUVBO1VBQ0E7VUFDQTs7OztVQ3RCQTtVQUNBO1VBQ0E7VUFDQSIsImZpbGUiOiJkaXN0LWJ1bmRsZS5qcyIsInNvdXJjZXNDb250ZW50IjpbIlwidXNlIHN0cmljdFwiO1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5kaXNjb25uZWN0ID0gZXhwb3J0cy5jb25uZWN0ID0gdm9pZCAwO1xuY29uc3QgYXhpb3NfMSA9IF9faW1wb3J0RGVmYXVsdChyZXF1aXJlKFwiYXhpb3NcIikpO1xuY29uc3QgY29ubmVjdCA9IGFzeW5jIChtc2cpID0+IHtcbiAgICBhd2FpdCBheGlvc18xLmRlZmF1bHQucG9zdChcImh0dHA6Ly9sb2NhbGhvc3Q6ODc4Ny9hcGkvZ2F0ZXdheS9jb25uZWN0L1wiLCBtc2cpO1xuICAgIHJldHVybiB7IHN0YXR1c0NvZGU6IDIwMCB9O1xufTtcbmV4cG9ydHMuY29ubmVjdCA9IGNvbm5lY3Q7XG5jb25zdCBkaXNjb25uZWN0ID0gYXN5bmMgKG1zZykgPT4ge1xuICAgIGF3YWl0IGF4aW9zXzEuZGVmYXVsdC5wb3N0KFwiaHR0cDovL2xvY2FsaG9zdDo4Nzg3L2FwaS9nYXRld2F5L2Rpc2Nvbm5lY3QvXCIsIG1zZyk7XG4gICAgcmV0dXJuIHsgc3RhdHVzQ29kZTogMjAwIH07XG59O1xuZXhwb3J0cy5kaXNjb25uZWN0ID0gZGlzY29ubmVjdDtcbiIsIlwidXNlIHN0cmljdFwiO1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5yX2RlZmF1bHQgPSB2b2lkIDA7XG5jb25zdCBheGlvc18xID0gX19pbXBvcnREZWZhdWx0KHJlcXVpcmUoXCJheGlvc1wiKSk7XG5jb25zdCByX2RlZmF1bHQgPSBhc3luYyAobXNnKSA9PiB7XG4gICAgYXdhaXQgYXhpb3NfMS5kZWZhdWx0LnBvc3QoXCJodHRwOi8vbG9jYWxob3N0Ojg3ODcvYXBpL2dhdGV3YXkvbWVzc2FnZVwiLCBtc2cpO1xuICAgIHJldHVybiB7IHN0YXR1c0NvZGU6IDIwMCB9O1xufTtcbmV4cG9ydHMucl9kZWZhdWx0ID0gcl9kZWZhdWx0O1xuIiwiXCJ1c2Ugc3RyaWN0XCI7XG52YXIgX19pbXBvcnREZWZhdWx0ID0gKHRoaXMgJiYgdGhpcy5fX2ltcG9ydERlZmF1bHQpIHx8IGZ1bmN0aW9uIChtb2QpIHtcbiAgICByZXR1cm4gKG1vZCAmJiBtb2QuX19lc01vZHVsZSkgPyBtb2QgOiB7IFwiZGVmYXVsdFwiOiBtb2QgfTtcbn07XG5PYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgXCJfX2VzTW9kdWxlXCIsIHsgdmFsdWU6IHRydWUgfSk7XG5leHBvcnRzLmhhbmRsZXIgPSB2b2lkIDA7XG5jb25zdCBhd3NfbGFtYmRhX3dzX3NlcnZlcl8xID0gX19pbXBvcnREZWZhdWx0KHJlcXVpcmUoXCJhd3MtbGFtYmRhLXdzLXNlcnZlclwiKSk7XG5jb25zdCBjb25uX2Rjb25uXzEgPSByZXF1aXJlKFwiLi9jb25uX2Rjb25uXCIpO1xuY29uc3QgZGVmYXVsdF8xID0gcmVxdWlyZShcIi4vZGVmYXVsdFwiKTtcbmV4cG9ydHMuaGFuZGxlciA9IGF3c19sYW1iZGFfd3Nfc2VydmVyXzEuZGVmYXVsdChhd3NfbGFtYmRhX3dzX3NlcnZlcl8xLmRlZmF1bHQuaGFuZGxlcih7XG4gICAgY29ubmVjdDogY29ubl9kY29ubl8xLmNvbm5lY3QsXG4gICAgZGlzY29ubmVjdDogY29ubl9kY29ubl8xLmRpc2Nvbm5lY3QsXG4gICAgZGVmYXVsdDogZGVmYXVsdF8xLnJfZGVmYXVsdFxufSkpO1xuIiwibW9kdWxlLmV4cG9ydHMgPSByZXF1aXJlKFwiYXdzLWxhbWJkYS13cy1zZXJ2ZXJcIik7OyIsIm1vZHVsZS5leHBvcnRzID0gcmVxdWlyZShcImF4aW9zXCIpOzsiLCIvLyBUaGUgbW9kdWxlIGNhY2hlXG52YXIgX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fID0ge307XG5cbi8vIFRoZSByZXF1aXJlIGZ1bmN0aW9uXG5mdW5jdGlvbiBfX3dlYnBhY2tfcmVxdWlyZV9fKG1vZHVsZUlkKSB7XG5cdC8vIENoZWNrIGlmIG1vZHVsZSBpcyBpbiBjYWNoZVxuXHR2YXIgY2FjaGVkTW9kdWxlID0gX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fW21vZHVsZUlkXTtcblx0aWYgKGNhY2hlZE1vZHVsZSAhPT0gdW5kZWZpbmVkKSB7XG5cdFx0cmV0dXJuIGNhY2hlZE1vZHVsZS5leHBvcnRzO1xuXHR9XG5cdC8vIENyZWF0ZSBhIG5ldyBtb2R1bGUgKGFuZCBwdXQgaXQgaW50byB0aGUgY2FjaGUpXG5cdHZhciBtb2R1bGUgPSBfX3dlYnBhY2tfbW9kdWxlX2NhY2hlX19bbW9kdWxlSWRdID0ge1xuXHRcdC8vIG5vIG1vZHVsZS5pZCBuZWVkZWRcblx0XHQvLyBubyBtb2R1bGUubG9hZGVkIG5lZWRlZFxuXHRcdGV4cG9ydHM6IHt9XG5cdH07XG5cblx0Ly8gRXhlY3V0ZSB0aGUgbW9kdWxlIGZ1bmN0aW9uXG5cdF9fd2VicGFja19tb2R1bGVzX19bbW9kdWxlSWRdLmNhbGwobW9kdWxlLmV4cG9ydHMsIG1vZHVsZSwgbW9kdWxlLmV4cG9ydHMsIF9fd2VicGFja19yZXF1aXJlX18pO1xuXG5cdC8vIFJldHVybiB0aGUgZXhwb3J0cyBvZiB0aGUgbW9kdWxlXG5cdHJldHVybiBtb2R1bGUuZXhwb3J0cztcbn1cblxuIiwiLy8gc3RhcnR1cFxuLy8gTG9hZCBlbnRyeSBtb2R1bGUgYW5kIHJldHVybiBleHBvcnRzXG4vLyBUaGlzIGVudHJ5IG1vZHVsZSBpcyByZWZlcmVuY2VkIGJ5IG90aGVyIG1vZHVsZXMgc28gaXQgY2FuJ3QgYmUgaW5saW5lZFxudmFyIF9fd2VicGFja19leHBvcnRzX18gPSBfX3dlYnBhY2tfcmVxdWlyZV9fKFwiLi9zcmMvbWFpbi50c1wiKTtcbiJdLCJzb3VyY2VSb290IjoiIn0=