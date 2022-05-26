import { promises as fs } from "fs";
import path from "path";

// A few help articles from this little script:
// https://stackoverflow.com/questions/34398279/map-and-filter-an-array-at-the-same-time
// https://stackoverflow.com/questions/63526473/flatmap-vs-reduce-for-mapping-and-filtering-is-one-recommended-over-the-other
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reduce
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/flatMap

// Method 1: Two passes, one for filtering the entries, another for mapping the name out of the Dirent
// const entries = (await fs.readdir("./",{ withFileTypes: true })).filter(entry => entry.isDirectory()).map(entry => entry.name);

// Method 2: One pass, making use of reduce
// const entries = (await fs.readdir("./",{ withFileTypes: true })).reduce((entries,entry) => {
//   if (entry.isDirectory()) entries.push(entry.name);
//   return entries;
// },[]);

// Method 3: flatMap! This one is really nice
const entries = (await fs.readdir("./",{ withFileTypes: true })).flatMap(entry => entry.isDirectory() ? [entry.name] : []);

for (const entry of entries){
  const textures = await fs.readdir(entry);
  for (const texture of textures){
    const simplified = entry.replace(/DefineSprite_/,"");
    const name = `${simplified}_${texture}`;
    await fs.rename(path.join(entry,texture),name);
  }
  await fs.rmdir(entry);
}