controladdin "Marquee Tag"
{
    RequestedWidth = 1450;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;

    Scripts = './MarqueeTag.js';
    StartupScript = './MarqueeTagStartup.js';

    event MarqueeTagReady()

    procedure UpdateMarqueeTag(_text: Text)
}