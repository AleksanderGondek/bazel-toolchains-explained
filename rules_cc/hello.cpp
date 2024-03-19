#include <chrono>
#include <ctime>
#include <iostream>

int main() {
  auto now =
      std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());

  std::cout << "Hello!" << std::endl;
  std::cout << "Currently date and time: "
            << std::put_time(std::localtime(&now), "%FT%T%z") << std::endl;

  return 0;
}
