package modules.members;
public class CheckPermission {
	public static boolean pass(int requiredPermission, String username) throws Exception{
		Users useragent = new Users();
		int resultdata = useragent.getUserDataInt(username, "permission");
		if (resultdata != -1) return (resultdata <= requiredPermission);
		return false;
	}
}
