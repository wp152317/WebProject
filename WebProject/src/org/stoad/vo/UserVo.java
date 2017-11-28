package org.stoad.vo;
//유저의 기본정보를 담고있는 table-gameuser 에 호환되는 클래스
public class UserVo {
	private String id;
	private String pwd;
	private String name;
	private String nickname;
	public UserVo() {
		super();
	}
	public UserVo(String id, String pwd) {
		this.id = id;
		this.pwd = pwd;
	}
	@Override
	public String toString() {
		return "UserVo [id=" + id + ", pwd=" + pwd + ", name=" + name + ", nickname=" + nickname + "]";
	}
	public UserVo(String id, String pwd, String name) {
		this(id,pwd);
		this.name = name;
		nickname = name;
	}
	public UserVo(String id, String pwd, String name, String nickname) {
		this(id,pwd,name);
		this.nickname = nickname;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
}
