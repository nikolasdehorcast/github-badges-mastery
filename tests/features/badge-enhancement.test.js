const BadgeTracker = require('../../src/features/badge-enhancement');

describe('BadgeTracker', () => {
  let tracker;
  
  beforeEach(() => {
    tracker = new BadgeTracker();
  });
  
  test('should update badge progress correctly', () => {
    tracker.updateProgress('Pull Shark', 50);
    
    const status = tracker.getStatus();
    expect(status.badges['Pull Shark'].percentage).toBe(50);
    expect(status.badges['Pull Shark'].status).toBe('in-progress');
  });
  
  test('should mark badge as completed when progress reaches 100%', () => {
    tracker.updateProgress('DevOps Guru', 100);
    
    const status = tracker.getStatus();
    expect(status.badges['DevOps Guru'].status).toBe('completed');
  });
  
  test('should calculate overall progress correctly', () => {
    tracker.updateProgress('Pull Shark', 100);
    tracker.updateProgress('DevOps Guru', 50);
    
    const status = tracker.getStatus();
    expect(status.completed).toBe(1);
    expect(status.total).toBe(2);
    expect(status.percentage).toBe(50);
  });
});
