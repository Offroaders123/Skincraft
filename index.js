import fs from "fs/promises";

async function run(){
  for await (const file of getFiles()){
    const valid = endsWith(file.path,".png",".jpg",".svg");
    console.log(file.path,valid);
    if (valid) console.log(file.path);
  }
}

async function* getFiles(path = "./"){
  const entries = await fs.readdir(path,{ withFileTypes: true });
  for (const file of entries){
    if (file.isDirectory()){
      yield* getFiles(`${path}${file.name}/`);
    } else {
      yield { ...file, path: `${path}${file.name}` };
    }
  }
}

function endsWith(string,...values){console.log(values);
  for (const value of values){
    console.log(value);
    if (!string.endsWith(value)) return false;
  }
  return true;
}

run();