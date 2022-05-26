import { promises as fs } from "fs";
import path from "path";

const output = {};

const entries = (await fs.readdir("./")).filter(entry => path.extname(entry) === ".txt");

for (const entry of entries){
  const key = path.parse(entry).name;
  const data = await fs.readFile(entry,{ encoding: "utf8" });
  output[key] = data.replace(/(\r\n|\r)/g,"\n");
  await fs.rm(entry);
}

const result = JSON.stringify(output,null,"  ");

await fs.writeFile("texts.json",result);