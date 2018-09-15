abstract class PowerPlant {
  turnOn();
}

class NuclearPlant implements PowerPlant {
  turnOn() {
    print("Im a nuclear plant turning on");
  }
}

class SolarPlant implements PowerPlant {
  turnOn() {
    print("Im a solar plant turning on");
  }
}

class PowerGrid {
  List<PowerPlant> connectedPlants = [];

  addPlant(PowerPlant plant) {
    connectedPlants.add(plant);
    plant.turnOn();
  }
}

void main() {
  PowerGrid grid = PowerGrid();
  NuclearPlant plantA = NuclearPlant();
  SolarPlant plantB = SolarPlant();

  grid.addPlant(plantA);
  grid.addPlant(plantB);
}
