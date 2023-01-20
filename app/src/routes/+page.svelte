<script>
// @ts-nocheck
	const canvasRows = 25;
	const canvasColumns = 25;
	let colorPalette = [
		{color: "red", selected: true}, 
		{color: "green", selected: false}, 
		{color: "blue", selected: false}, 
		{color: "black", selected: false}
	];
	let brushColor = "red";

	/** @type {string[][]}*/
	let canvas = [];
	
	for (let row = 0; row < canvasRows; row++) {
		canvas[row] = [];
		for (let column = 0; column < canvasColumns; column++) {
			canvas[row][column] = "black";
		}
	}

	function updatePixel(row, column) {
		canvas[row][column] = brushColor;
	}

	function updateBrushColor(color) {
		brushColor = color;
		colorPalette.forEach((paint) => {
			paint.selected = false;
			if (paint.color === color) {
				paint.selected = true;
			}
		});
		colorPalette = colorPalette;
	}

</script>

<main>
	<h1>Budget Photoshop</h1>
	<br>
	<table class="canvas">
		{#each canvas as row, rowIndex}
		<tr>
			{#each row as pixel, columnIndex}
			<td on:click={() => updatePixel(rowIndex, columnIndex)} class="pixel {canvas[rowIndex][columnIndex]}">
			</td>
			{/each}
		</tr>
		{/each}
	</table>
	<br>
	<h2>Color Palette</h2>
	<table class="color palette">
		<tr>
			{#each colorPalette as {color, selected} (color)}
				{#if selected}
					<td on:click={() => updateBrushColor(color)} class="paint {color}">★</td>
				{:else}
					<td on:click={() => updateBrushColor(color)} class="paint {color}"></td>
				{/if}
			{/each}
		</tr>
	</table>
</main>

<style>
	h1, h2{
		text-align: center;
	}

	.canvas, .color.palette {
		margin-left:auto; 
		margin-right:auto;
		text-align: center;
		color: white;
		background-color: rebeccapurple;
	}
	
	.pixel, .paint {
		width: 25px;
		height: 25px;
	}

	.paint {
		width: 125px;
	}
	.pixel.red, .paint.red {
		background-color: red;
	}
	.pixel.green, .paint.green {
		background-color: green;
	}
	.pixel.blue, .paint.blue {
		background-color: blue;
	}
	.pixel.black, .paint.black {
		background-color: black;
	}
	.pixel:hover {
		opacity: 50%;
	}
</style>