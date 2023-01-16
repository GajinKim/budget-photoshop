<script>
    export let data;
    /** @type {boolean[][]}*/
    let board = data.initialBoard;
    let rows = data.initialRows;
    let columns = data.initialColumns;
    let isToggling = false
    
    /**
     * @param {number} row 
     * @param {number} column 
     * @param {boolean} alive
    */
    function updateState(row, column, alive) {
        board[row][column] = alive;
    }

    function increaseDensity() {
        rows *= 2;
        columns *= 2;
        for(let row = 0; row < rows; row++) {
            board[row] ??= [];
            for(let column = 0; column < columns; column++) {
                board[row][column] ??= false;
            }
        }
    }

    function decreaseCellDensity() {
        if (columns <= 16) {
            window.alert('16 x 9 is the lowest resolution!');
            return;
        }
        columns = Math.round(columns / 2);
        rows = Math.round(rows / 2);
        board.splice(rows);
        for(let row = 0; row < rows; row++) {
            board[row].splice(columns);
            board[row] = [...board[row]];
        }

        board =[...board];
    }
</script>

<table id="board">
    {#each board as row, rowIndex}
        <tr>
            {#each row as cell, columnIndex}
                <!-- svelte-ignore a11y-click-events-have-key-events -->
                <!-- svelte-ignore a11y-mouse-events-have-key-events -->
                <td on:click={(e) => updateState(rowIndex, columnIndex, !e.metaKey && !e.ctrlKey)} class="cell {cell ? "alive" : "dead"}">
                </td>
            {/each}
        </tr>
    {/each}
</table>

<p>Click Cell to turn alive (blue)</p>
<p>Ctrl+Click a Cell to turn it dead (black)</p>

<br />

<button on:click={increaseDensity}>Increase Cell Density</button>
<button on:click={decreaseCellDensity}>Decrease Cell Density</button>

<br />
<br />

<p id="cell-density">Cell Density: {columns} x {rows} ({rows * columns} cells)</p>

<style>
* {
padding: 0;
margin: 0;
border: 0;
}

body {
overflow: hidden;
}

#board {
width: 800px;
height: 450px;

/* jank centering */
position: absolute;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
}

.cell.dead {
background-color: black;
}

.cell.alive {
background-color: blue;
}

.cell:hover {
background-color: red;
}
</style>