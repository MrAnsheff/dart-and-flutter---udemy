class PowerGrid {
  List<NuclearPlant> connectedPlants = [];

  addPlant(NuclearPlant plant) {
    connectedPlants.add(plant);
    plant.turnOn();
  }
}

class NuclearPlant {
  turnOn() {
    print("Im a nuclear plant turning on");
  }
}

void main() {
  PowerGrid grid = PowerGrid();
  NuclearPlant plantA = NuclearPlant();

  grid.addPlant(plantA);
}
