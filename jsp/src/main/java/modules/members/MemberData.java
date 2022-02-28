package modules.members;

public class MemberData {
    public int exitCondition = 0;
    private String id = "";
    private String username = "";
    private String password = "";
    private String realname = "";
    private int passattempt = 0;
    private int permission = 400;
    private String status = "PENDING";
    private String email = "";
    private String userrole = "";
    private String photoAddress = "";
    private String recoveryLink = "";
    private int strikes = 0;
    private String bio = "";
    private String category = "";

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public int getPassattempt() {
        return passattempt;
    }

    public void setPassattempt(int passattempt) {
        this.passattempt = passattempt;
    }

    public int getPermission() {
        return permission;
    }

    public void setPermission(int permission) {
        this.permission = permission;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserrole() {
        return userrole;
    }

    public void setUserrole(String userrole) {
        this.userrole = userrole;
    }

    public String getPhotoAddress() {
        return photoAddress;
    }

    public void setPhotoAddress(String photoAddress) {
        this.photoAddress = photoAddress;
    }

    public String getRecoveryLink() {
        return recoveryLink;
    }

    public void setRecoveryLink(String recoveryLink) {
        this.recoveryLink = recoveryLink;
    }

    public int getStrikes() {
        return strikes;
    }

    public void setStrikes(int strikes) {
        this.strikes = strikes;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void removeSensitiveData() { // Run this on login success
        password = "";
        recoveryLink = "";
    }

    public boolean hasPermissionOf(int requiredPermission) {
        return (requiredPermission >= permission);
    }
}
