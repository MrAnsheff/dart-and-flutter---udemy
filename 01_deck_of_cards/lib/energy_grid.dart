abstract class PowerPlant {
  int maxKwHour;
  turnOn(int minPower);
}

class NuclearPlant implements PowerPlant {
  int maxKwHour = 100;

  turnOn(int minPower) {
    print(
        "Im a solar plant turning on at $minPower capacity. My max capacity is $maxKwHour");
  }
}

class SolarPlant implements PowerPlant {
  int maxKwHour = 150;
  turnOn(int minPower) {
    print(
        "Im a solar plant turning on at $minPower capacity. My max capacity is $maxKwHour");
  }
}

class PowerGrid {
  List<PowerPlant> connectedPlants = [];

  addPlant(PowerPlant plant) {
    connectedPlants.add(plant);
    plant.turnOn(200);
  }
}

void main() {
  PowerGrid grid = PowerGrid();
  NuclearPlant plantA = NuclearPlant();
  SolarPlant plantB = SolarPlant();

  grid.addPlant(plantA);
  grid.addPlant(plantB);
}
