function UpdateMarqueeTag(_text) {


    var tag = document.getElementById("myMarqueeTag");
    if (tag != null) {
        tag.remove();
    }
    var marqueeTag = document.createElement("marquee");
    marqueeTag.id = "myMarqueeTag";
    marqueeTag.direction = "left";
    marqueeTag.style.backgroundColor = "rgb(217 240 242)";
    marqueeTag.style.fontSize = "xx-large";
    marqueeTag.style.height = "40px";
    var textNode = document.createTextNode(_text);
    marqueeTag.appendChild(textNode);
    var mainIframe = document.getElementById('controlAddIn');
    mainIframe.append(marqueeTag);
}