import { promises as fs } from "fs";
import path from "path";

const entries = (await fs.readdir("./")).filter(entry => path.extname(entry) === ".png");

for (const entry of entries){
  const simplified = path.parse(entry).name.split("_")[1];
  await fs.rename(entry,simplified);
  console.log(simplified);
}