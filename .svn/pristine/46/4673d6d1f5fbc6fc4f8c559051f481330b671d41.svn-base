package com.maryun.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.maryun.model.PageData;

public class BootstrapUtils {
	/**
	 * 将查询结果与分页信息封装为bootstrampTable认可的结构
	 * 
	 * @param totalSize 总数量
	 * @param dbResult List<Map>结构
	 * @return
	 */
	public static Map<Object, Object> parsePage2BootstrmpTable(Long totalSize, List dbResult) {
		if (dbResult == null)
			dbResult = new ArrayList();
		Map<Object, Object> dataTable = new HashMap<Object, Object>();
		dataTable.put("total", totalSize);
		dataTable.put("rows", dbResult);
		return dataTable;
	}
	
	

	/**
	 * 将数据列表封装成bootstrap-treeview所需要的结构
	 * 
	 * @param dataList
	 *            数据列表
	 * @param rootId
	 *            根节点的id的值，一般为“0”
	 * @param rootText
	 *            根节点显示的值
	 * @param idCol
	 *            id对应的数据库列
	 * @param textCol
	 *            text对应的数据库列
	 * @param pidCol
	 *            pid对应的数据库列
	 * @param otherCols
	 *            其他需要放到树节点的属性及其数据库对应的字段，例如name,USERNAME,age,USERAGE形式，必须成对出现
	 * @return
	 */
	public static List<PageData> getTree(List<PageData> dataList,
			String rootId, String rootText, String idCol, String textCol,
			String pidCol, String... otherCols) {
		Map root = new HashMap();
		root.put("id", rootId);
		root.put("text", rootText);
		root.put("nodes", new ArrayList());

		Map<String, Map> temp = new HashMap<String, Map>();
		int paramLength = 0;

		if (otherCols.length % 2 != 0) {
			paramLength = (otherCols.length - 1) / 2;
		} else {
			paramLength = otherCols.length / 2;
		}

		for (PageData pd : dataList) {
			Map node = new HashMap();
			node.put("id", pd.get(idCol).toString());
			node.put("text", pd.get(textCol).toString());
			node.put("nodes", new ArrayList());
			for (int i = 0; i < paramLength; i++) {
				if (pd.containsKey(otherCols[i * 2 + 1])) {
					node.put(otherCols[i * 2], pd.get(otherCols[i * 2 + 1])
							.toString());
				} else {
					continue;
				}

			}

			temp.put(pd.get(idCol).toString(), node);
		}

		for (PageData pd : dataList) {
			String id = pd.get(idCol).toString();
			String pid = pd.get(pidCol).toString();

			if (rootId.equals(pid)) {
				((ArrayList) root.get("nodes")).add(temp.get(id));
			} else {
				((ArrayList) temp.get(pid).get("nodes")).add(temp.get(id));
			}

		}

		List retList = new ArrayList();
		retList.add(root);

		return retList;
	}
	
	/**
	 * 将数据列表封装成bootstrap-treeview复选模式所需要的结构
	 * 
	 * @param dataList
	 *            数据列表
	 * @param dataList
	 *            关系表中存在关系的列表
	 * @param rootId
	 *            根节点的id的值，一般为“0”
	 * @param rootText
	 *            根节点显示的值
	 * @param idCol
	 *            id对应的数据库列
	 * @param textCol
	 *            text对应的数据库列
	 * @param pidCol
	 *            pid对应的数据库列
	 * @param otherCols
	 *            其他需要放到树节点的属性及其数据库对应的字段，例如name,USERNAME,age,USERAGE形式，必须成对出现
	 * @return
	 */
	public static List<PageData> getCheckTree(List<PageData> dataList,
			List<PageData> checkedList, String rootId, String rootText,
			String idCol, String textCol, String pidCol, String... otherCols) {
		Map root = new HashMap();
		root.put("id", rootId);
		root.put("text", rootText);
//		Map state=new HashMap();
//		state.put("checked", true);
//		root.put("state", state);
		root.put("showCheckbox", false);
		root.put("nodes", new ArrayList());

		Map<String, Map> temp = new HashMap<String, Map>();
		int paramLength = 0;

		if (otherCols.length % 2 != 0) {
			paramLength = (otherCols.length - 1) / 2;
		} else {
			paramLength = otherCols.length / 2;
		}

		for (PageData pd : dataList) {
			Map node = new HashMap();
            boolean flag=false;//在关系表中是否找到该menu
			for (PageData pData : checkedList) {
				if (pData.containsKey(idCol) && pd.containsKey(idCol)) {
					if (pData.get(idCol).toString()
							.equals(pd.get(idCol).toString())) {
						Map state1=new HashMap();
						state1.put("checked", true);
						node.put("state",state1);
						flag=true;
						break;
					}
				}
			}
			node.put("id", pd.get(idCol).toString());
			node.put("text", pd.get(textCol).toString());
			node.put("nodes", new ArrayList());
			for (int i = 0; i < paramLength; i++) {
				if (pd.containsKey(otherCols[i * 2 + 1])) {
					node.put(otherCols[i * 2], pd.get(otherCols[i * 2 + 1]).toString());
				} else {
					continue;
				}
			}
			temp.put(pd.get(idCol).toString(), node);
		}

		for (PageData pd : dataList) {
			String id = pd.get(idCol).toString();
			String pid = pd.get(pidCol).toString();

			if (rootId.equals(pid)) {
				((ArrayList) root.get("nodes")).add(temp.get(id));
			} else {
				((ArrayList) temp.get(pid).get("nodes")).add(temp.get(id));
			}

		}

		List retList = new ArrayList();
		retList.add(root);

		return retList;
	}
	
	/**
	 * 将数据列表封装成bootstrap-treeview所需要的结构
	 * 只有最后一级才显示复选框
	 * @param dataList
	 *            数据列表
	 * @param rootId
	 *            根节点的id的值，一般为“0”
	 * @param rootText
	 *            根节点显示的值
	 * @param idCol
	 *            id对应的数据库列
	 * @param textCol
	 *            text对应的数据库列
	 * @param pidCol
	 *            pid对应的数据库列
	 * @param otherCols
	 *            其他需要放到树节点的属性及其数据库对应的字段，例如name,USERNAME,age,USERAGE形式，必须成对出现
	 * @return
	 */
	public static List<PageData> getChartsTree(List<PageData> dataList,
			String rootId, String rootText, String idCol, String textCol,
			String pidCol, String... otherCols) {
		Map root = new HashMap();
		root.put("id", rootId);
		root.put("text", rootText);
		root.put("showCheckbox", false);
		root.put("nodes", new ArrayList());

		Map<String, Map> temp = new HashMap<String, Map>();
		int paramLength = 0;

		if (otherCols.length % 2 != 0) {
			paramLength = (otherCols.length - 1) / 2;
		} else {
			paramLength = otherCols.length / 2;
		}

		for (PageData pd : dataList) {
			Map node = new HashMap();
			node.put("id", pd.get(idCol).toString());
			node.put("text", pd.get(textCol).toString());
			node.put("showCheckbox", false);
			node.put("nodes", new ArrayList());
			for (int i = 0; i < paramLength; i++) {
				if (pd.containsKey(otherCols[i * 2 + 1])) {
					node.put(otherCols[i * 2], pd.get(otherCols[i * 2 + 1]).toString());
				} else {
					continue;
				}
			}
			temp.put(pd.get(idCol).toString(), node);
		}

		for (PageData pd : dataList) {
			String id = pd.get(idCol).toString();
			String pid = pd.get(pidCol).toString();

			if (rootId.equals(pid)) {
				((ArrayList) root.get("nodes")).add(temp.get(id));
			} else {
				temp.get(id).put("showCheckbox", true);
				((ArrayList) temp.get(pid).get("nodes")).add(temp.get(id));
			}
		}

		List retList = new ArrayList();
		retList.add(root);

		return retList;
	}
	
	
	
	static int index = 1;   //每一列的索引

	   //构造前台table所需内容，返回String字符串
		public static String getTreeGrid(List<PageData> allMenuList,
				List<PageData> roleMenuList, List<PageData> allbuttonList,
				List<PageData> roleButtonListGlobal, List<PageData> roleButtonList) {
			// 构造列表树结构
			List<PageData> orderList = new ArrayList<PageData>();
			Map<String, PageData> allMap = new HashMap<String, PageData>();
			Map<String, PageData> tempMap = new HashMap<String, PageData>();

			for (PageData menu : allMenuList) {
				allMap.put(menu.getString("MENU_ID"), menu);
			}

			for (PageData menu : roleMenuList) {
				if (tempMap.containsKey(menu.getString("MENU_ID")))
					continue;

				if (StringUtils.isNotBlank(menu.getString("PARENT_ID"))
						|| "0".equals(menu.getString("PARENT_ID"))) {
					if(allMap.containsKey(menu.getString("MENU_ID")))
						orderList.add(allMap.get(menu.getString("MENU_ID")));
					tempMap.put(menu.getString("MENU_ID"), menu);
				} else {
					PageData parentMenu = allMap.get(menu.getString("PARENT_ID"));
					PageData tempMenu = menu;
					do {
						Object subMenu=null;
						if (subMenu == null) {
							ArrayList<PageData> subMenuList=new ArrayList<PageData>();
							subMenuList.add(tempMenu);
							parentMenu.put("SubMenu",subMenuList);
						} else {
							ArrayList<PageData> subMenuList=(ArrayList<PageData>)parentMenu.get("SubMenu");
							subMenuList.add(tempMenu);
							parentMenu.put("SubMenu",subMenuList);
						}

						if (StringUtils.isNotBlank(parentMenu.getString("PARENT_ID"))
								|| "0".equals(parentMenu.getString("PARENT_ID"))) {
							if (!tempMap.containsKey(parentMenu.getString("MENU_ID"))) {
								if(allMap.containsKey(parentMenu.getString("MENU_ID")))
									orderList.add(allMap.get(parentMenu.getString("MENU_ID")));
								tempMap.put(parentMenu.getString("MENU_ID"), parentMenu);
							}
							break;
						}
						tempMenu = parentMenu;
						parentMenu = allMap.get(parentMenu.getString("PARENT_ID"));
					} while (true);
				}

			}
			// 以下是构造treeGrid全局button行
			StringBuilder sBuilder = new StringBuilder();
	        index=1;  //初始化index变量
			//currMenuIndex = index;
			sBuilder.append("<tr class=\"treegrid-" + (index++) + "\"><td>");
			sBuilder.append("全部");
			sBuilder.append("</td>");
			for (PageData pd : allbuttonList) {
				boolean isChecked = false;
				for (PageData pdData : roleButtonListGlobal) {
					if (pdData.getString("BUTTON_ID").equals(
							pd.getString("BUTTON_ID"))) {
						isChecked = true;
						break;
					}
				}
				if (isChecked) {
					sBuilder.append("<td>" + "<input type=\"checkbox\" id=\""
							+ pd.getString("BUTTON_ID") + "\" checked>"
							+ pd.getString("BUTTON_NAME") + "</td>");

				} else {
					sBuilder.append("<td>" + "<input type=\"checkbox\" id=\""
							+ pd.getString("BUTTON_ID") + "\">"
							+ pd.getString("BUTTON_NAME") + "</td>");
				}

			}
			sBuilder.append("</tr>");
			// 以下是构造根菜单的代码（包含勾选）
			for (PageData menu : orderList) {
				sBuilder.append("<tr class=\"treegrid-" + index
						+ " treegrid-parent-1\"><td>");
				sBuilder.append(menu.getString("MENU_NAME"));
				sBuilder.append("</td>");
				// 构造复选框
				for (PageData pd : allbuttonList) {
					boolean isChecked = false;
					for (PageData pdData : roleButtonList) {
						if (pdData.get("MENU_ID").toString()
								.equals(menu.getString("MENU_ID"))) {
							if (pdData.getString("BUTTON_ID").equals(
									pd.getString("BUTTON_ID"))) {
								isChecked = true;
								break;
							}
						}
					}
					// 如果该角色存在此按钮则勾选复选框，否则不勾选
					if (isChecked) {
						sBuilder.append("<td>" + "<input type=\"checkbox\" id=\""
								+ menu.getString("MENU_ID") + ","
								+ pd.getString("BUTTON_ID") + "\" checked>"
								+ pd.getString("BUTTON_NAME") + "</td>");

					} else {
						sBuilder.append("<td>" + "<input type=\"checkbox\" id=\""
								+ menu.getString("MENU_ID") + ","
								+ pd.getString("BUTTON_ID") + "\">"
								+ pd.getString("BUTTON_NAME") + "</td>");
					}

				}
				sBuilder.append("</tr>");
				// 以下是构造叶子节点菜单的代码(递归调用 )
				buildChildNode(menu, sBuilder, roleButtonList, allbuttonList);
				index++;

			}
			return sBuilder.toString();
		}
		
		
		
	    //递归方法逐级构造节点
		public static void buildChildNode(PageData tempMenu, StringBuilder sBuilder,
				List<PageData> roleButtonList, List<PageData> allbuttonList) {
			if (tempMenu.get("SubMenu") != null) {
				int currMenuIndex = index++;
				for (PageData childMenu : (List<PageData>)tempMenu.get("SubMenu")) {
					sBuilder.append("<tr class=\"treegrid-" + index
							+ " treegrid-parent-" + currMenuIndex + "\"><td>");
					sBuilder.append(childMenu.getString("MENU_NAME"));
					sBuilder.append("</td>");
					for (PageData pd : allbuttonList) {
						boolean isChecked = false;
						for (PageData pdData : roleButtonList) {
							if (pdData.get("MENU_ID").toString()
									.equals(childMenu.getString("MENU_ID"))) {
								if (pdData.getString("BUTTON_ID").equals(
										pd.getString("BUTTON_ID"))) {
									isChecked = true;
									break;
								}
							}
						}
						if (isChecked) {
							sBuilder.append("<td>"
									+ "<input type=\"checkbox\" id=\""
									+ childMenu.getString("MENU_ID") + ","
									+ pd.getString("BUTTON_ID") + "\" checked>"
									+ pd.getString("BUTTON_NAME") + "</td>");

						} else {
							sBuilder.append("<td>"
									+ "<input type=\"checkbox\" id=\""
									+ childMenu.getString("MENU_ID") + ","
									+ pd.getString("BUTTON_ID") + "\">"
									+ pd.getString("BUTTON_NAME") + "</td>");
						}

					}

					sBuilder.append("</tr>");
					buildChildNode(childMenu, sBuilder, roleButtonList,
							allbuttonList);
					index++;
				}
			}
		}
	
	
	
	
}
