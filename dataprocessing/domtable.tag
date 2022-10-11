code written by ruth
https://en.wikipedia.org/wiki/Operation_Hurricane
dom begin
function selectElementContents(el) {
    var body = document.body, range, sel;
    if (document.createRange && window.getSelection) {
        range = document.createRange();
        sel = window.getSelection();
        sel.removeAllRanges();
        try {
            range.selectNodeContents(el);
            sel.addRange(range);
        } catch (e) {
            range.selectNode(el);
            sel.addRange(range);
        }
        document.execCommand("copy");
    } else if (body.createTextRange) {
        range = body.createTextRange();
        range.moveToElementText(el);
        range.select();
    }
    return range;
}
return selectElementContents(document.getElementsByClassName('wikitable')[0]).toString();
//return JSON.stringify(selectElementContents(document.getElementsByClassName('wikitable')[0]));

dom finish
echo `dom_result`
[workbook.xlsx]Sheet1!A1:I4 = dom_result
