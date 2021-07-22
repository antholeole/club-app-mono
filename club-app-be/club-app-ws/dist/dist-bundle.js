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
    console.log(to);
    try {
        const resp = await axios_1.default.post(`http://localhost:8787/api/gateway/${to}/`, msg);
        data = resp.data;
        statusCode = resp.status;
    }
    catch (err) {
        const e = err;
        data = (_a = e.response) === null || _a === void 0 ? void 0 : _a.data;
        statusCode = (_c = (_b = e.response) === null || _b === void 0 ? void 0 : _b.status) !== null && _c !== void 0 ? _c : 999;
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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9jbHViLWFwcC13cy8uL3NyYy9heGlvc19yZXEudHMiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvLi9zcmMvbWFpbi50cyIsIndlYnBhY2s6Ly9jbHViLWFwcC13cy9leHRlcm5hbCBcImF3cy1sYW1iZGEtd3Mtc2VydmVyXCIiLCJ3ZWJwYWNrOi8vY2x1Yi1hcHAtd3MvZXh0ZXJuYWwgXCJheGlvc1wiIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svYm9vdHN0cmFwIiwid2VicGFjazovL2NsdWItYXBwLXdzL3dlYnBhY2svc3RhcnR1cCJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOzs7Ozs7Ozs7O0FBQWE7QUFDYjtBQUNBLDRDQUE0QztBQUM1QztBQUNBLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxnQkFBZ0I7QUFDaEIsZ0NBQWdDLG1CQUFPLENBQUMsb0JBQU87QUFDL0M7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EscUZBQXFGLEdBQUc7QUFDeEY7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLFlBQVk7QUFDWjtBQUNBLGdCQUFnQjs7Ozs7Ozs7Ozs7QUN4Qkg7QUFDYjtBQUNBLDRDQUE0QztBQUM1QztBQUNBLDhDQUE2QyxDQUFDLGNBQWMsRUFBQztBQUM3RCxlQUFlO0FBQ2YsK0NBQStDLG1CQUFPLENBQUMsa0RBQXNCO0FBQzdFLG9CQUFvQixtQkFBTyxDQUFDLHVDQUFhO0FBQ3pDLGVBQWU7QUFDZjtBQUNBO0FBQ0E7QUFDQSxDQUFDOzs7Ozs7Ozs7OztBQ1pELGtEOzs7Ozs7Ozs7O0FDQUEsbUM7Ozs7OztVQ0FBO1VBQ0E7O1VBRUE7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7O1VBRUE7VUFDQTs7VUFFQTtVQUNBO1VBQ0E7Ozs7VUN0QkE7VUFDQTtVQUNBO1VBQ0EiLCJmaWxlIjoiZGlzdC1idW5kbGUuanMiLCJzb3VyY2VzQ29udGVudCI6WyJcInVzZSBzdHJpY3RcIjtcbnZhciBfX2ltcG9ydERlZmF1bHQgPSAodGhpcyAmJiB0aGlzLl9faW1wb3J0RGVmYXVsdCkgfHwgZnVuY3Rpb24gKG1vZCkge1xuICAgIHJldHVybiAobW9kICYmIG1vZC5fX2VzTW9kdWxlKSA/IG1vZCA6IHsgXCJkZWZhdWx0XCI6IG1vZCB9O1xufTtcbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCBcIl9fZXNNb2R1bGVcIiwgeyB2YWx1ZTogdHJ1ZSB9KTtcbmV4cG9ydHMuYXhpb3NSZXEgPSB2b2lkIDA7XG5jb25zdCBheGlvc18xID0gX19pbXBvcnREZWZhdWx0KHJlcXVpcmUoXCJheGlvc1wiKSk7XG5jb25zdCBheGlvc1JlcSA9IGFzeW5jICh0bywgbXNnKSA9PiB7XG4gICAgdmFyIF9hLCBfYiwgX2M7XG4gICAgbGV0IGRhdGE7XG4gICAgbGV0IHN0YXR1c0NvZGU7XG4gICAgY29uc29sZS5sb2codG8pO1xuICAgIHRyeSB7XG4gICAgICAgIGNvbnN0IHJlc3AgPSBhd2FpdCBheGlvc18xLmRlZmF1bHQucG9zdChgaHR0cDovL2xvY2FsaG9zdDo4Nzg3L2FwaS9nYXRld2F5LyR7dG99L2AsIG1zZyk7XG4gICAgICAgIGRhdGEgPSByZXNwLmRhdGE7XG4gICAgICAgIHN0YXR1c0NvZGUgPSByZXNwLnN0YXR1cztcbiAgICB9XG4gICAgY2F0Y2ggKGVycikge1xuICAgICAgICBjb25zdCBlID0gZXJyO1xuICAgICAgICBkYXRhID0gKF9hID0gZS5yZXNwb25zZSkgPT09IG51bGwgfHwgX2EgPT09IHZvaWQgMCA/IHZvaWQgMCA6IF9hLmRhdGE7XG4gICAgICAgIHN0YXR1c0NvZGUgPSAoX2MgPSAoX2IgPSBlLnJlc3BvbnNlKSA9PT0gbnVsbCB8fCBfYiA9PT0gdm9pZCAwID8gdm9pZCAwIDogX2Iuc3RhdHVzKSAhPT0gbnVsbCAmJiBfYyAhPT0gdm9pZCAwID8gX2MgOiA5OTk7XG4gICAgfVxuICAgIHJldHVybiB7IHN0YXR1c0NvZGUsIGJvZHk6IGRhdGEgfTtcbn07XG5leHBvcnRzLmF4aW9zUmVxID0gYXhpb3NSZXE7XG4iLCJcInVzZSBzdHJpY3RcIjtcbnZhciBfX2ltcG9ydERlZmF1bHQgPSAodGhpcyAmJiB0aGlzLl9faW1wb3J0RGVmYXVsdCkgfHwgZnVuY3Rpb24gKG1vZCkge1xuICAgIHJldHVybiAobW9kICYmIG1vZC5fX2VzTW9kdWxlKSA/IG1vZCA6IHsgXCJkZWZhdWx0XCI6IG1vZCB9O1xufTtcbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCBcIl9fZXNNb2R1bGVcIiwgeyB2YWx1ZTogdHJ1ZSB9KTtcbmV4cG9ydHMuaGFuZGxlciA9IHZvaWQgMDtcbmNvbnN0IGF3c19sYW1iZGFfd3Nfc2VydmVyXzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcImF3cy1sYW1iZGEtd3Mtc2VydmVyXCIpKTtcbmNvbnN0IGF4aW9zX3JlcV8xID0gcmVxdWlyZShcIi4vYXhpb3NfcmVxXCIpO1xuZXhwb3J0cy5oYW5kbGVyID0gYXdzX2xhbWJkYV93c19zZXJ2ZXJfMS5kZWZhdWx0KGF3c19sYW1iZGFfd3Nfc2VydmVyXzEuZGVmYXVsdC5oYW5kbGVyKHtcbiAgICBjb25uZWN0OiAobSkgPT4gYXhpb3NfcmVxXzEuYXhpb3NSZXEoJ2Nvbm5lY3QnLCBtKSxcbiAgICBkaXNjb25uZWN0OiAobSkgPT4gYXhpb3NfcmVxXzEuYXhpb3NSZXEoJ2Rpc2Nvbm5lY3QnLCBtKSxcbiAgICBkZWZhdWx0OiAobSkgPT4gYXhpb3NfcmVxXzEuYXhpb3NSZXEoJ21lc3NhZ2UnLCBtKSxcbn0pKTtcbiIsIm1vZHVsZS5leHBvcnRzID0gcmVxdWlyZShcImF3cy1sYW1iZGEtd3Mtc2VydmVyXCIpOzsiLCJtb2R1bGUuZXhwb3J0cyA9IHJlcXVpcmUoXCJheGlvc1wiKTs7IiwiLy8gVGhlIG1vZHVsZSBjYWNoZVxudmFyIF9fd2VicGFja19tb2R1bGVfY2FjaGVfXyA9IHt9O1xuXG4vLyBUaGUgcmVxdWlyZSBmdW5jdGlvblxuZnVuY3Rpb24gX193ZWJwYWNrX3JlcXVpcmVfXyhtb2R1bGVJZCkge1xuXHQvLyBDaGVjayBpZiBtb2R1bGUgaXMgaW4gY2FjaGVcblx0dmFyIGNhY2hlZE1vZHVsZSA9IF9fd2VicGFja19tb2R1bGVfY2FjaGVfX1ttb2R1bGVJZF07XG5cdGlmIChjYWNoZWRNb2R1bGUgIT09IHVuZGVmaW5lZCkge1xuXHRcdHJldHVybiBjYWNoZWRNb2R1bGUuZXhwb3J0cztcblx0fVxuXHQvLyBDcmVhdGUgYSBuZXcgbW9kdWxlIChhbmQgcHV0IGl0IGludG8gdGhlIGNhY2hlKVxuXHR2YXIgbW9kdWxlID0gX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fW21vZHVsZUlkXSA9IHtcblx0XHQvLyBubyBtb2R1bGUuaWQgbmVlZGVkXG5cdFx0Ly8gbm8gbW9kdWxlLmxvYWRlZCBuZWVkZWRcblx0XHRleHBvcnRzOiB7fVxuXHR9O1xuXG5cdC8vIEV4ZWN1dGUgdGhlIG1vZHVsZSBmdW5jdGlvblxuXHRfX3dlYnBhY2tfbW9kdWxlc19fW21vZHVsZUlkXS5jYWxsKG1vZHVsZS5leHBvcnRzLCBtb2R1bGUsIG1vZHVsZS5leHBvcnRzLCBfX3dlYnBhY2tfcmVxdWlyZV9fKTtcblxuXHQvLyBSZXR1cm4gdGhlIGV4cG9ydHMgb2YgdGhlIG1vZHVsZVxuXHRyZXR1cm4gbW9kdWxlLmV4cG9ydHM7XG59XG5cbiIsIi8vIHN0YXJ0dXBcbi8vIExvYWQgZW50cnkgbW9kdWxlIGFuZCByZXR1cm4gZXhwb3J0c1xuLy8gVGhpcyBlbnRyeSBtb2R1bGUgaXMgcmVmZXJlbmNlZCBieSBvdGhlciBtb2R1bGVzIHNvIGl0IGNhbid0IGJlIGlubGluZWRcbnZhciBfX3dlYnBhY2tfZXhwb3J0c19fID0gX193ZWJwYWNrX3JlcXVpcmVfXyhcIi4vc3JjL21haW4udHNcIik7XG4iXSwic291cmNlUm9vdCI6IiJ9