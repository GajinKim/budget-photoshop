
// columns to rows ratio should be 16:9 for perfect cells
function Board(height, columns = 16, rows = 9) {
      this.height = height;
      this.width = Math.round(height * (16 / 9));

      this.columns = columns;
      this.rows = rows;
}

function toggleCellColor(element) {
      if (window.event.ctrlKey) {
            element.style.backgroundColor = "black";
      } else {
            element.style.backgroundColor = "blue";
      }
}

Board.prototype.createCells = function () {
      let boardHTML = "";
      for (let row = 0; row < this.rows; row++) {
            boardHTML += `<tr>`;
            for (let col = 0; col < this.columns; col++) {
                  boardHTML += `<td class="cell" id="` + row + `,` + col + `" onclick='toggleCellColor(this);'></td>`;
            }
            boardHTML += `</tr>`;
      }
      let board = document.getElementById("board");
      board.innerHTML = boardHTML;
}


let newBoard = new Board(900);
newBoard.createCells();


function increaseCellDensity() {
      newBoard.columns *= 2;
      newBoard.rows *= 2;
      newBoard.createCells();
      document.getElementById("cell-density").innerHTML = `Cell Density: ` + Math.round(newBoard.columns) + ` x ` + Math.round(newBoard.rows) + ` (` + Math.round(newBoard.columns) * Math.round(newBoard.rows) + ` cells)`;
}

function decreaseCellDensity() {
      if (newBoard.columns <= 8) {
            window.alert('8 x 5 is the lowest resolution!');
      } else {
            newBoard.columns /= 2;
            newBoard.rows /= 2;
            newBoard.createCells();
            document.getElementById("cell-density").innerHTML = `Cell Density: ` + Math.round(newBoard.columns) + ` x ` + Math.round(newBoard.rows) + ` (` + Math.round(newBoard.columns) * Math.round(newBoard.rows) + ` cells)`;
      }
}
