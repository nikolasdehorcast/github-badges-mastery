/**
 * Feature: Badge Enhancement System
 * Developed through pair programming
 * 
 * This module demonstrates collaborative development
 * for GitHub badge achievement.
 */

class BadgeTracker {
  constructor() {
    this.badges = new Map();
    this.progress = {};
  }
  
  /**
   * Track badge progress
   * @param {string} badgeName - Name of the badge
   * @param {number} progress - Progress percentage (0-100)
   */
  updateProgress(badgeName, progress) {
    this.progress[badgeName] = {
      percentage: progress,
      timestamp: new Date().toISOString(),
      status: progress >= 100 ? 'completed' : 'in-progress'
    };
    
    console.log(`📊 ${badgeName}: ${progress}% complete`);
    
    if (progress >= 100) {
      console.log(`🏆 Badge "${badgeName}" achieved!`);
    }
  }
  
  /**
   * Get current badge status
   * @returns {Object} Badge progress summary
   */
  getStatus() {
    const completed = Object.values(this.progress)
      .filter(badge => badge.status === 'completed').length;
    const total = Object.keys(this.progress).length;
    
    return {
      completed,
      total,
      percentage: total > 0 ? Math.round((completed / total) * 100) : 0,
      badges: this.progress
    };
  }
}

module.exports = BadgeTracker;
