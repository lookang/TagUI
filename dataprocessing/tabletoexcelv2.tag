https://www.w3schools.com/html/html_tables.asp
dom begin
function table2array(tableId) {
  var table = document.getElementById(tableId);
  var output = [];
  for (var y = 0; y < table.rows.length; y++) {
    output.push([]);
    var row = table.rows[y];

    for (var x = 0; x < row.cells.length; x++) {
      output[y].push(row.cells[x].innerHTML);
    }
  }
  return output;
}

var output = JSON.stringify(table2array("customers"));
return output
/*
return [
  [ "Company", "Contact", "Country" ],
  [ "Alfreds Futterkiste", "Maria Anders", "Germany" ],
  [ "Centro comercial Moctezuma", "Francisco Chang", "Mexico" ],
  [ "Ernst Handel", "Roland Mendel", "Austria" ],
  [ "Island Trading", "Helen Bennett", "UK" ],
  [ "Laughing Bacchus Winecellars", "Yoshi Tannamuri", "Canada" ],
  [ "Magazzini Alimentari Riuniti", "Giovanni Rovelli", "Italy" ]
]
*/
dom finish
echo `dom_result`
[out.xlsx]Sheet1!A1 = `dom_result`
