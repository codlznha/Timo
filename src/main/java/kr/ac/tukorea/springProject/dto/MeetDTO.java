package kr.ac.tukorea.springProject.dto;

import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;

public class MeetDTO {
    private int id;
    private String type;         // DB의 meet_type과 매핑됨
    private String title;
    private int currentMembers;  // DB의 current_members
    private int maxMembers;      // DB의 max_members
    
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime startTime; // DB의 start_time
    private LocalDateTime endTime;
    
    private String item;
    private LocalDateTime created;
    private String status;       // DB의 meet_status와 매핑됨

    private String location; 
    private String description;
    private Double lat;
    private Double lng;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getCurrentMembers() {
		return currentMembers;
	}
	public void setCurrentMembers(int currentMembers) {
		this.currentMembers = currentMembers;
	}
	public int getMaxMembers() {
		return maxMembers;
	}
	public void setMaxMembers(int maxMembers) {
		this.maxMembers = maxMembers;
	}
	public LocalDateTime getStartTime() {
		return startTime;
	}
	public void setStartTime(LocalDateTime startTime) {
		this.startTime = startTime;
	}
	public LocalDateTime getEndTime() {
		return endTime;
	}
	public void setEndTime(LocalDateTime endTime) {
		this.endTime = endTime;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public LocalDateTime getCreated() {
		return created;
	}
	public void setCreated(LocalDateTime created) {
		this.created = created;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}
	public Double getLng() {
		return lng;
	}
	public void setLng(Double lng) {
		this.lng = lng;
	}

    // Getter & Setter ...
    
}