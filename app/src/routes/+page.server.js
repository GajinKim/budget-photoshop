
/** @type {import('./$types').PageServerLoad} */
export function load() {
    let initialRows = 9;
    let initialColumns = 16;
    /** @type {boolean[][]}*/
    let initialBoard = [];
    for(let row = 0; row < initialRows; row++) {
        initialBoard[row] = [];
        for(let column = 0; column < initialColumns; column++) {
            initialBoard[row][column] = false;

            // checkerboard pattern
            // initialBoard[row][column] = (row + column) % 2 == 0; 
        }
    }
    return {
        initialRows,
        initialColumns,
        initialBoard
    };
}
