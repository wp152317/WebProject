package org.stoad.vo;
//유저의 기록을 담는 table-gamerecord와 1:1 대응되는 클래스
public class RecordVo {
	private String id;
	private String nickname;
	private int score;
	
	public RecordVo() {
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	
}
