<script>
	/**
	 * @type {{ todos: any; }}
	 */
	 export let data;
</script>

<h1>Home Page</h1>

<form method="POST">
	<label>
		<h2>Add item to <u>todo</u> list:</h2>
		<input name="description" />
	</label>
</form>

<ul>
	{#each data.todos as todo (todo.id)}
		<li class="todo">
			{todo.description}
		</li>
	{/each}
</ul>
