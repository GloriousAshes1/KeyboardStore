package com.keyboardstore.entity;
// Generated May 18, 2024, 11:32:32 AM by Hibernate Tools 4.3.6.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@NamedQueries({
	@NamedQuery(name = "Users.findAll", query = "SELECT u FROM Users u ORDER BY u.fullName"),
	@NamedQuery(name = "Users.findByEmail", query = "SELECT u FROM Users u WHERE u.email = :email"),
	@NamedQuery(name = "Users.countAll", query = "SELECT Count(*) FROM Users u"),
	@NamedQuery(name = "Users.checkLogin", query = "SELECT u FROM Users u WHERE u.email = :email AND password = :password"),
		@NamedQuery(name = "Users.search", query = "SELECT u FROM Users u WHERE u.fullName LIKE :query OR u.email LIKE :query")

})
@Table(name = "users", catalog = "keyboardstoredb")
public class Users implements java.io.Serializable {

	private Integer userId;
	private String email;
	private String password;
	private String fullName;
	private String role;

	public Users() {
	}

	public Users(String email, String fullName , String password, String role) {
		super();
		this.email = email;
		this.fullName = fullName;
		this.password = password;
		this.role = role;
	}
	
	public Users(Integer userId, String email, String fullName , String password, String role) {
		this(email,fullName,password,role);
		this.userId = userId;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "user_id", unique = true, nullable = false)
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Column(name = "email", nullable = false, length = 30)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "password", nullable = false, length = 16)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "full_name", nullable = false, length = 30)
	public String getFullName() {
		return this.fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	@Column(name = "role", nullable = false, length = 50)
	public String getRole() {return this.role;}

	public void setRole(String role) {this.role = role;}
}
