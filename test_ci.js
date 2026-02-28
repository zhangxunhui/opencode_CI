/**
 * 防抖函数
 * @param {Function} fn 要执行的函数
 * @param {number} delay 延迟时间（毫秒）
 * @returns {Function} 防抖后的函数
 */
function debounce(fn, delay) {
  let timer = null;
  
  return function(...args) {
    // 如果已有定时器，清除重新计时
    if (timer) clearTimeout(timer);
    
    // 设置新的定时器
    timer = setTimeout(() => {
      fn.apply(this, args);
    }, delay);
  };
}

// 使用示例
const handleSearch = debounce((searchText) => {
  console.log('搜索:', searchText);
  // 这里可以调用API
}, 500);

// 在输入框上使用
input.addEventListener('input', (e) => handleSearch(e.target.value));
