import { promises as fs } from "fs";
import path from "path";

async function getFilePathsFromDirectory(directoryPath,{ recursive = false } = {}){
  const filePaths = [];
  for await (const entry of await fs.readdir(directoryPath,{ withFileTypes: true })){
    if (entry.isDirectory() && recursive === true){
      filePaths.push(await getFilePathsFromDirectory(`${directoryPath}${entry.name}/`,{ recursive }));
    } else {
      filePaths.push(path.join(directoryPath,entry.name).split(path.sep).join(path.posix.sep));
    }
  }
  return (recursive === true) ? filePaths.flat(Infinity) : filePaths;
}

const files = await getFilePathsFromDirectory("./",{ recursive: true });
fs.writeFile("output.json",JSON.stringify(files,null,"  "));