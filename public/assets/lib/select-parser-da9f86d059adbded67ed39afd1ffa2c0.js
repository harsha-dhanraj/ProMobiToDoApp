(function(){var e;(e=function(){function e(){this.options_index=0,this.parsed=[]}return e.prototype.add_node=function(e){return"OPTGROUP"===e.nodeName.toUpperCase()?this.add_group(e):this.add_option(e)},e.prototype.add_group=function(e){var t,s,i,n,d,r;for(t=this.parsed.length,this.parsed.push({array_index:t,group:!0,label:this.escapeExpression(e.label),title:e.title?e.title:void 0,children:0,disabled:e.disabled,classes:e.className}),r=[],s=0,i=(d=e.childNodes).length;s<i;s++)n=d[s],r.push(this.add_option(n,t,e.disabled));return r},e.prototype.add_option=function(e,t,s){if("OPTION"===e.nodeName.toUpperCase())return""!==e.text?(null!=t&&(this.parsed[t].children+=1),this.parsed.push({array_index:this.parsed.length,options_index:this.options_index,value:e.value,text:e.text,html:e.innerHTML,title:e.title?e.title:void 0,selected:e.selected,disabled:!0===s?s:e.disabled,group_array_index:t,group_label:null!=t?this.parsed[t].label:null,classes:e.className,style:e.style.cssText})):this.parsed.push({array_index:this.parsed.length,options_index:this.options_index,empty:!0}),this.options_index+=1},e.prototype.escapeExpression=function(e){var t,s;return null==e||!1===e?"":/[\&\<\>\"\'\`]/.test(e)?(t={"<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#x27;","`":"&#x60;"},s=/&(?!\w+;)|[\<\>\"\'\`]/g,e.replace(s,function(e){return t[e]||"&amp;"})):e},e}()).select_to_array=function(t){var s,i,n,d,r;for(d=new e,i=0,n=(r=t.childNodes).length;i<n;i++)s=r[i],d.add_node(s);return d.parsed},window.SelectParser=e}).call(this);