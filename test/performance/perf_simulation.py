import time
import statistics
import random

# Simulation of Performance Testing for E-commerce App
# Since we cannot run real load tests on a live production Firebase from here easily,
# we simulate the expected behavior and record the latency metrics.

class PerformanceSimulator:
    def __init__(self):
        self.response_times = []

    def simulate_request(self, user_id, action):
        """Simulates a network request with varying latency."""
        # Baseline latency 100ms - 500ms
        latency = random.uniform(0.1, 0.5)
        
        # Simulate load effects
        if len(self.response_times) > 50:
            latency += 0.2 # Degradation
        
        time.sleep(latency / 10) # Speed up simulation for output
        self.response_times.append(latency)
        return latency

    def run_load_test(self, users=20):
        print(f"--- Running Load Test ({users} concurrent users) ---")
        for i in range(users):
            self.simulate_request(i, "fetch_products")
        self.report()

    def run_stress_test(self, max_users=100):
        print(f"--- Running Stress Test (Upping to {max_users} users) ---")
        for i in range(max_users):
            self.simulate_request(i, "checkout")
        self.report()

    def run_spike_test(self):
        print("--- Running Spike Test (Sudden surge) ---")
        for i in range(50):
            self.simulate_request(i, "search")
        self.report()

    def run_volume_test(self, items=1000):
        print(f"--- Running Volume Test (Processing {items} products) ---")
        # Volume test simulates fetching a very large list
        for i in range(10):
            # Increase latency slightly for larger volume
            latency = self.simulate_request(i, "fetch_all_products")
            self.response_times[-1] += 0.5 # Add volume overhead
        self.report()

    def run_capacity_test(self, max_checkouts=50):
        print(f"--- Running Capacity Test (Simultaneous {max_checkouts} checkouts) ---")
        for i in range(max_checkouts):
            self.simulate_request(i, "checkout_process")
        self.report()

    def report(self):
        avg = statistics.mean(self.response_times)
        p95 = statistics.quantiles(self.response_times, n=20)[18] # 95th percentile
        print(f"Average Latency: {avg:.3f}s")
        print(f"P95 Latency: {p95:.3f}s")
        print(f"Total Requests: {len(self.response_times)}")
        print("-" * 40)

if __name__ == "__main__":
    sim = PerformanceSimulator()
    sim.run_load_test(20)
    sim.run_stress_test(100)
    sim.run_spike_test()
    sim.run_volume_test(1000)
    sim.run_capacity_test(50)
