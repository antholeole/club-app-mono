/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./src/axios_req.ts":
/*!**************************!*\
  !*** ./src/axios_req.ts ***!
  \**************************/
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.axiosReq = void 0;
const axios_1 = __importDefault(__webpack_require__(/*! axios */ "axios"));
const axiosReq = async (to, msg) => {
    var _a, _b, _c;
    let data;
    let statusCode;
    try {
        const resp = await axios_1.default.post(`http://localhost:8787/api/gateway/${to}/`, msg);
        data = resp.data;
        statusCode = resp.status;
    }
    catch (err) {
        const e = err;
        data = (_a = e.response) === null || _a === void 0 ? void 0 : _a.data;
        statusCode = (_c = (_b = e.response) === null || _b === void 0 ? void 0 : _b.status) !== null && _c !== void 0 ? _c : 99;
    }
    return { statusCode, body: data };
};
exports.axiosReq = axiosReq;


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
const axios_req_1 = __webpack_require__(/*! ./axios_req */ "./src/axios_req.ts");
exports.handler = aws_lambda_ws_server_1.default(aws_lambda_ws_server_1.default.handler({
    connect: (m) => axios_req_1.axiosReq('connect', m),
    disconnect: (m) => axios_req_1.axiosReq('disconnect', m),
    default: (m) => axios_req_1.axiosReq('message', m),
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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9jbHViLWFwcC13cy8uL3NyYy9heGlvc19yZXEudHMiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvLi9zcmMvbWFpbi50cyIsIndlYnBhY2s6Ly9jbHViLWFwcC13cy9leHRlcm5hbCBcImF3cy1sYW1iZGEtd3Mtc2VydmVyXCIiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvZXh0ZXJuYWwgXCJheGlvc1wiIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svYm9vdHN0cmFwIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svc3RhcnR1cCJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOzs7Ozs7Ozs7O0FBQWE7QUFDYjtBQUNBLDRDQUE0QztBQUM1QztBQUNBLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxnQkFBZ0I7QUFDaEIsZ0NBQWdDLG1CQUFPLENBQUMsb0JBQU87QUFDL0M7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLHFGQUFxRixHQUFHO0FBQ3hGO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxZQUFZO0FBQ1o7QUFDQSxnQkFBZ0I7Ozs7Ozs7Ozs7O0FDdkJIO0FBQ2I7QUFDQSw0Q0FBNEM7QUFDNUM7QUFDQSw4Q0FBNkMsQ0FBQyxjQUFjLEVBQUM7QUFDN0QsZUFBZTtBQUNmLCtDQUErQyxtQkFBTyxDQUFDLGtEQUFzQjtBQUM3RSxvQkFBb0IsbUJBQU8sQ0FBQyx1Q0FBYTtBQUN6QyxlQUFlO0FBQ2Y7QUFDQTtBQUNBO0FBQ0EsQ0FBQzs7Ozs7Ozs7Ozs7QUNaRCxrRDs7Ozs7Ozs7OztBQ0FBLG1DOzs7Ozs7VUNBQTtVQUNBOztVQUVBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBOztVQUVBO1VBQ0E7O1VBRUE7VUFDQTtVQUNBOzs7O1VDdEJBO1VBQ0E7VUFDQTtVQUNBIiwiZmlsZSI6ImRpc3QtYnVuZGxlLmpzIiwic291cmNlc0NvbnRlbnQiOlsiXCJ1c2Ugc3RyaWN0XCI7XG52YXIgX19pbXBvcnREZWZhdWx0ID0gKHRoaXMgJiYgdGhpcy5fX2ltcG9ydERlZmF1bHQpIHx8IGZ1bmN0aW9uIChtb2QpIHtcbiAgICByZXR1cm4gKG1vZCAmJiBtb2QuX19lc01vZHVsZSkgPyBtb2QgOiB7IFwiZGVmYXVsdFwiOiBtb2QgfTtcbn07XG5PYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgXCJfX2VzTW9kdWxlXCIsIHsgdmFsdWU6IHRydWUgfSk7XG5leHBvcnRzLmF4aW9zUmVxID0gdm9pZCAwO1xuY29uc3QgYXhpb3NfMSA9IF9faW1wb3J0RGVmYXVsdChyZXF1aXJlKFwiYXhpb3NcIikpO1xuY29uc3QgYXhpb3NSZXEgPSBhc3luYyAodG8sIG1zZykgPT4ge1xuICAgIHZhciBfYSwgX2IsIF9jO1xuICAgIGxldCBkYXRhO1xuICAgIGxldCBzdGF0dXNDb2RlO1xuICAgIHRyeSB7XG4gICAgICAgIGNvbnN0IHJlc3AgPSBhd2FpdCBheGlvc18xLmRlZmF1bHQucG9zdChgaHR0cDovL2xvY2FsaG9zdDo4Nzg3L2FwaS9nYXRld2F5LyR7dG99L2AsIG1zZyk7XG4gICAgICAgIGRhdGEgPSByZXNwLmRhdGE7XG4gICAgICAgIHN0YXR1c0NvZGUgPSByZXNwLnN0YXR1cztcbiAgICB9XG4gICAgY2F0Y2ggKGVycikge1xuICAgICAgICBjb25zdCBlID0gZXJyO1xuICAgICAgICBkYXRhID0gKF9hID0gZS5yZXNwb25zZSkgPT09IG51bGwgfHwgX2EgPT09IHZvaWQgMCA/IHZvaWQgMCA6IF9hLmRhdGE7XG4gICAgICAgIHN0YXR1c0NvZGUgPSAoX2MgPSAoX2IgPSBlLnJlc3BvbnNlKSA9PT0gbnVsbCB8fCBfYiA9PT0gdm9pZCAwID8gdm9pZCAwIDogX2Iuc3RhdHVzKSAhPT0gbnVsbCAmJiBfYyAhPT0gdm9pZCAwID8gX2MgOiA5OTtcbiAgICB9XG4gICAgcmV0dXJuIHsgc3RhdHVzQ29kZSwgYm9keTogZGF0YSB9O1xufTtcbmV4cG9ydHMuYXhpb3NSZXEgPSBheGlvc1JlcTtcbiIsIlwidXNlIHN0cmljdFwiO1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5oYW5kbGVyID0gdm9pZCAwO1xuY29uc3QgYXdzX2xhbWJkYV93c19zZXJ2ZXJfMSA9IF9faW1wb3J0RGVmYXVsdChyZXF1aXJlKFwiYXdzLWxhbWJkYS13cy1zZXJ2ZXJcIikpO1xuY29uc3QgYXhpb3NfcmVxXzEgPSByZXF1aXJlKFwiLi9heGlvc19yZXFcIik7XG5leHBvcnRzLmhhbmRsZXIgPSBhd3NfbGFtYmRhX3dzX3NlcnZlcl8xLmRlZmF1bHQoYXdzX2xhbWJkYV93c19zZXJ2ZXJfMS5kZWZhdWx0LmhhbmRsZXIoe1xuICAgIGNvbm5lY3Q6IChtKSA9PiBheGlvc19yZXFfMS5heGlvc1JlcSgnY29ubmVjdCcsIG0pLFxuICAgIGRpc2Nvbm5lY3Q6IChtKSA9PiBheGlvc19yZXFfMS5heGlvc1JlcSgnZGlzY29ubmVjdCcsIG0pLFxuICAgIGRlZmF1bHQ6IChtKSA9PiBheGlvc19yZXFfMS5heGlvc1JlcSgnbWVzc2FnZScsIG0pLFxufSkpO1xuIiwibW9kdWxlLmV4cG9ydHMgPSByZXF1aXJlKFwiYXdzLWxhbWJkYS13cy1zZXJ2ZXJcIik7OyIsIm1vZHVsZS5leHBvcnRzID0gcmVxdWlyZShcImF4aW9zXCIpOzsiLCIvLyBUaGUgbW9kdWxlIGNhY2hlXG52YXIgX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fID0ge307XG5cbi8vIFRoZSByZXF1aXJlIGZ1bmN0aW9uXG5mdW5jdGlvbiBfX3dlYnBhY2tfcmVxdWlyZV9fKG1vZHVsZUlkKSB7XG5cdC8vIENoZWNrIGlmIG1vZHVsZSBpcyBpbiBjYWNoZVxuXHR2YXIgY2FjaGVkTW9kdWxlID0gX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fW21vZHVsZUlkXTtcblx0aWYgKGNhY2hlZE1vZHVsZSAhPT0gdW5kZWZpbmVkKSB7XG5cdFx0cmV0dXJuIGNhY2hlZE1vZHVsZS5leHBvcnRzO1xuXHR9XG5cdC8vIENyZWF0ZSBhIG5ldyBtb2R1bGUgKGFuZCBwdXQgaXQgaW50byB0aGUgY2FjaGUpXG5cdHZhciBtb2R1bGUgPSBfX3dlYnBhY2tfbW9kdWxlX2NhY2hlX19bbW9kdWxlSWRdID0ge1xuXHRcdC8vIG5vIG1vZHVsZS5pZCBuZWVkZWRcblx0XHQvLyBubyBtb2R1bGUubG9hZGVkIG5lZWRlZFxuXHRcdGV4cG9ydHM6IHt9XG5cdH07XG5cblx0Ly8gRXhlY3V0ZSB0aGUgbW9kdWxlIGZ1bmN0aW9uXG5cdF9fd2VicGFja19tb2R1bGVzX19bbW9kdWxlSWRdLmNhbGwobW9kdWxlLmV4cG9ydHMsIG1vZHVsZSwgbW9kdWxlLmV4cG9ydHMsIF9fd2VicGFja19yZXF1aXJlX18pO1xuXG5cdC8vIFJldHVybiB0aGUgZXhwb3J0cyBvZiB0aGUgbW9kdWxlXG5cdHJldHVybiBtb2R1bGUuZXhwb3J0cztcbn1cblxuIiwiLy8gc3RhcnR1cFxuLy8gTG9hZCBlbnRyeSBtb2R1bGUgYW5kIHJldHVybiBleHBvcnRzXG4vLyBUaGlzIGVudHJ5IG1vZHVsZSBpcyByZWZlcmVuY2VkIGJ5IG90aGVyIG1vZHVsZXMgc28gaXQgY2FuJ3QgYmUgaW5saW5lZFxudmFyIF9fd2VicGFja19leHBvcnRzX18gPSBfX3dlYnBhY2tfcmVxdWlyZV9fKFwiLi9zcmMvbWFpbi50c1wiKTtcbiJdLCJzb3VyY2VSb290IjoiIn0=