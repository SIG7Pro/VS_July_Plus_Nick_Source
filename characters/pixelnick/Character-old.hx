function create() {
	character.frames = Paths.getCharacter(character.curCharacter);
	character.loadPsychJSON(true);
}