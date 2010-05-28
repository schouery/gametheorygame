// Trasnformar em unobstrusive
function remove_fields(link) {  
    $(link).prev("input[type=hidden]").val("1");  
    $(link).closest(".fields").hide();  
}  
  
function add_fields(link, association, content) {  
    var new_id = new Date().getTime();  
    var regexp = new RegExp("new_" + association, "g");  
    $(link).parent().before(content.replace(regexp, new_id));  
}

function number_of_columns() {
  var columns = 0;
  $("tr.master").first().children().each(function(index) {columns += 1});
  return columns;
}

function number_of_lines() {
  var lines = 0;
  $("tr.master").each(function(index) {lines += 1});      
  return lines;
}

function add_column(link, strategy, payoff) {
    var new_id = new Date().getTime();  
    var regexp_payoff = new RegExp("new_payoff", "g");  
    var regexp_strategy = new RegExp("new_strategy", "g");
    var columns = number_of_columns();
    var lines = number_of_lines();
    $("tr.master").each( function(index) {
      if (index == 0) {
        $(this).children().last().prev().after("<td>" + strategy.replace(regexp_strategy, new_id) + "</td>");
        $(this).children().last().prev().find("input.number").val(columns - 2);
        $(this).children().last().prev().find("input.player_number").val(2);
      } else {
        if (index < lines-1) {
          new_id += 1;
          $(this).children().last().after("<td>" + payoff.replace(regexp_payoff, new_id) + "</td>");
          $(this).children().last().find("input.line").val(index-1);
          $(this).children().last().find("input.column").val(columns-2);
        }
      }
    });
}
 
function add_line(link, strategy, payoff) {
  var new_id = new Date().getTime();  
  var regexp_payoff = new RegExp("new_payoff", "g");  
  var regexp_strategy = new RegExp("new_strategy", "g");
  var columns = number_of_columns();
  var lines = number_of_lines();
  var line = "<tr class='master'>";
  for(i = 0; i < columns - 1; i++){
    if(i == 0) {
      line += "<td>" + strategy.replace(regexp_strategy, new_id) + "</td>";
    } else {
      new_id += 1;
      line += "<td>" + payoff.replace(regexp_payoff, new_id) + "</td>";
    }
  }
  line = line + "</tr>";  
  $("tr.master").last().prev().after(line);
  $("tr.master").last().prev().children().each(function(index) {
    if (index == 0) {
      $(this).find("input.number").val(lines - 2);
      $(this).find("input.player_number").val(1);
    } else {
      if (index < columns-1) {
        $(this).find("input.line").val(lines-2);
        $(this).find("input.column").val(index-1);        
      }
    }   
  });
}