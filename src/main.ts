/* eslint-disable no-console */

import { createServer, IncomingMessage, ServerResponse } from "node:http";

const hostname = process.env.HOST ?? "127.0.0.1";
const port = Number(process.env.PORT ?? 8080);

const server = createServer((req: IncomingMessage, res: ServerResponse) => {
  console.log(`Serving request: ${req.method} ${req.url}`);
  res.statusCode = 200;
  res.setHeader("Content-Type", "text/plain");
  res.end("Hello World");
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
