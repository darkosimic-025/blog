document.addEventListener("turbo:submit-end", function(event) {
    if (event.target.id === "new_comment") {
        event.target.reset();
    }
});
