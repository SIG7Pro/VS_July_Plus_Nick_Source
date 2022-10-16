var stage:Stage = null;
function create() {
	stage = loadStage('nickroom-evil');
}
function update(elapsed) {
	stage.update(elapsed);
}
function beatHit(curBeat) {
	stage.onBeat();
}