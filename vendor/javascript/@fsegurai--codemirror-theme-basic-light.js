import{EditorView as o}from"@codemirror/view";import{HighlightStyle as r,syntaxHighlighting as e}from"@codemirror/language";import{tags as t}from"@lezer/highlight";const c="#2e3440",a="#3b4252",l="#434c5e",n="#4c566a";const i="#e5e9f0",g="#eceff4";const d="#8fbcbb",m="#88c0d0",s="#81a1c1",b="#5e81ac";const p="#bf616a",f="#d08770",u="#ebcb8b",h="#a3be8c",k="#b48ead";const C="#d30102",B=g,x="#7692a033",N="#ffffff",v=i,y="#6dceff85",w="#02b8ff57",W=a;const L=o.theme({"&":{color:c,backgroundColor:N},".cm-content":{caretColor:W},".cm-cursor, .cm-dropCursor":{borderLeftColor:W},"&.cm-focused > .cm-scroller > .cm-selectionLayer .cm-selectionBackground, .cm-selectionBackground, .cm-content ::selection":{backgroundColor:y,color:"#00008b"},".cm-panels":{backgroundColor:B,color:n},".cm-panels.cm-panels-top":{borderBottom:"2px solid black"},".cm-panels.cm-panels-bottom":{borderTop:"2px solid black"},".cm-searchMatch":{backgroundColor:"#72a1ff59",outline:`1px solid ${n}`},".cm-searchMatch.cm-searchMatch-selected":{backgroundColor:i},".cm-activeLine":{backgroundColor:x},".cm-selectionMatch":{backgroundColor:w},"&.cm-focused .cm-matchingBracket, &.cm-focused .cm-nonmatchingBracket":{outline:`1px solid ${n}`},"&.cm-focused .cm-matchingBracket":{backgroundColor:g},".cm-gutters":{backgroundColor:g,color:c,border:"none"},".cm-activeLineGutter":{backgroundColor:y,color:"#00008b"},".cm-foldPlaceholder":{backgroundColor:"transparent",border:"none",color:"#ddd"},".cm-tooltip":{border:"none",backgroundColor:v},".cm-tooltip .cm-tooltip-arrow:before":{borderTopColor:"transparent",borderBottomColor:"transparent"},".cm-tooltip .cm-tooltip-arrow:after":{borderTopColor:v,borderBottomColor:v},".cm-tooltip-autocomplete":{"& > ul > li[aria-selected]":{color:n}}},{dark:false});const M=r.define([{tag:t.keyword,color:b},{tag:[t.name,t.deleted,t.character,t.propertyName,t.macroName],color:f},{tag:[t.variableName],color:f},{tag:[t.function(t.variableName)],color:b},{tag:[t.labelName],color:s},{tag:[t.color,t.constant(t.name),t.standard(t.name)],color:b},{tag:[t.definition(t.name),t.separator],color:h},{tag:[t.brace],color:d},{tag:[t.annotation],color:C},{tag:[t.number,t.changed,t.annotation,t.modifier,t.self,t.namespace],color:m},{tag:[t.typeName,t.className],color:u},{tag:[t.operator,t.operatorKeyword],color:h},{tag:[t.tagName],color:k},{tag:[t.squareBracket],color:p},{tag:[t.angleBracket],color:f},{tag:[t.attributeName],color:u},{tag:[t.regexp],color:b},{tag:[t.quote],color:a},{tag:[t.string],color:f},{tag:t.link,color:d,textDecoration:"underline",textUnderlinePosition:"under"},{tag:[t.url,t.escape,t.special(t.string)],color:f},{tag:[t.meta],color:m},{tag:[t.comment],color:l,fontStyle:"italic"},{tag:t.strong,fontWeight:"bold",color:b},{tag:t.emphasis,fontStyle:"italic",color:b},{tag:t.strikethrough,textDecoration:"line-through"},{tag:t.heading,fontWeight:"bold",color:b},{tag:t.special(t.heading1),fontWeight:"bold",color:b},{tag:t.heading1,fontWeight:"bold",color:b},{tag:[t.heading2,t.heading3,t.heading4],fontWeight:"bold",color:b},{tag:[t.heading5,t.heading6],color:b},{tag:[t.atom,t.bool,t.special(t.variableName)],color:f},{tag:[t.processingInstruction,t.inserted],color:d},{tag:[t.contentSeparator],color:u},{tag:t.invalid,color:l,borderBottom:`1px dotted ${C}`}]);const S=[L,e(M)];export{S as basicLight,M as basicLightHighlightStyle,L as basicLightTheme};

