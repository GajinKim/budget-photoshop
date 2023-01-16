/** @type {import('./$types').PageLoad} */
export function load({ params }) {
        return {
                title: "Pog Title",
                post: {
                        a: "apple",
                        b: "banana"
                }
        };
}