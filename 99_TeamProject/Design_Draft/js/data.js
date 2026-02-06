const CATEGORY_MAP = {
  top: ["coat","shirts","sweater"],
  bottom: ["pants","skirts"],
  set: ["onepiece","suit"],
  shoes: ["dressshoe","sandals"],
  acc: ["bag","hat"]
};

const PRODUCT_DB = [];
let id = 1;

// 자동 상품 생성
for(const main in CATEGORY_MAP){
  CATEGORY_MAP[main].forEach(sub=>{
    for(let i=1;i<=12;i++){
      PRODUCT_DB.push({
        id:id++,
        name:`${sub} ${i}`,
        main:main,
        sub:sub,
        img:`img/${main}/${sub}/${i}.jpg`,
        price: Math.floor(Math.random()*80000)+20000
      });
    }
  });
}
