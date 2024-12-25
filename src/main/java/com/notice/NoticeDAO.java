package com.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.utility.DBClose;
import com.utility.DBOpen;

public class NoticeDAO {
	
	public int total(String col, String word) {
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from notice ");
		
		if (word.trim().length() > 0 && col.equals("title_content")) {
		      sql.append(" where title like concat('%' , ? , '%')  ");
		      sql.append(" or content like concat('%' , ? , '%')  ");
	    } else if (word.trim().length() > 0) {
	      sql.append(" where " + col + " like concat('%' , ? , '%')  ");
	    }
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			if (word.trim().length() > 0 && col.equals("title_content")) {
			    pstmt.setString(1, word);
			    pstmt.setString(2, word);
			} else if (word.trim().length() > 0) {
			  pstmt.setString(1, word);
			}
			
			rs = pstmt.executeQuery();
			
			rs.next();
			total = rs.getInt(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return total;
	}
	
	public List<NoticeDTO> list(Map map){
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT noticeno, wname, title, rdate, cnt ");
		sql.append(" FROM notice ");
		if (word.trim().length() > 0 && col.equals("title_content")) {
		      sql.append(" where title like concat('%' , ? , '%')  ");
		      sql.append(" or content like concat('%' , ? , '%')  ");
	    } else if (word.trim().length() > 0) {
	      sql.append(" where " + col + " like concat('%' , ? , '%')  ");
	    }
		
		sql.append(" order by noticeno desc");
		sql.append(" limit ?, ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			
			if (word.trim().length() > 0 && col.equals("title_content")) {
			    pstmt.setString(++i, word);
			    pstmt.setString(++i, word);
			} else if (word.trim().length() > 0) {
			  pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNoticeno(rs.getInt("noticeno"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setRdate(rs.getString("rdate"));
				dto.setCnt(rs.getInt("cnt"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return list;
	}
	
	public List<NoticeDTO> nList(Map map){
		List<NoticeDTO> nlist = new ArrayList<NoticeDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select noticeno, wname, title, rdate, cnt ");
		sql.append(" from notice ");
		sql.append(" order by noticeno desc");

		
		try {
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNoticeno(rs.getInt("noticeno"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setRdate(rs.getString("rdate"));
				dto.setCnt(rs.getInt("cnt"));
				
				nlist.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return nlist;
	}
	
	public boolean create(NoticeDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into notice( wname, title, content, passwd, rdate ) ");
        sql.append(" values(?, ?, ?, ?, now()) ");
        
        try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
	
	public NoticeDTO read(int noticeno) {
		NoticeDTO dto = null;
	    Connection con = DBOpen.open();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    StringBuffer sql = new StringBuffer();
        sql.append(" select noticeno, wname, title, content, cnt, rdate ");
        sql.append(" from notice ");
        sql.append(" where noticeno = ?  ");
	    
	    try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
		        dto = new NoticeDTO();
		        dto.setNoticeno(rs.getInt("noticeno"));
		        dto.setWname(rs.getString("wname"));
		        dto.setTitle(rs.getString("title"));
		        dto.setContent(rs.getString("content"));
		        dto.setCnt(rs.getInt("cnt"));
		        dto.setRdate(rs.getString("rdate"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return dto;
	}
	
	public void upViewcnt(int noticeno) {
		Connection con = DBOpen.open();
	    PreparedStatement pstmt = null;
	    
	    StringBuffer sql = new StringBuffer();
	    sql.append(" update notice ");
	    sql.append(" set cnt = cnt + 1 ");
	    sql.append(" where noticeno = ? ");
	    
	    try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
	}
	
	public NoticeDTO readNext(int noticeno) {
		NoticeDTO ndto = null;
		Connection con = DBOpen.open();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    StringBuffer sql = new StringBuffer();
	    sql.append(" select noticeno, wname, title, content, cnt, rdate ");
        sql.append(" from notice ");
        sql.append(" where noticeno = ?  ");
        
        try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno + 1);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ndto = new NoticeDTO();
				ndto.setNoticeno(rs.getInt("noticeno"));
				ndto.setWname(rs.getString("wname"));
				ndto.setTitle(rs.getString("title"));
				ndto.setCnt(rs.getInt("cnt"));
				ndto.setRdate(rs.getString("rdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
	    
	    return ndto;
	}
	
	public NoticeDTO readPrior(int noticeno) {
		NoticeDTO pdto = null;
		Connection con = DBOpen.open();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    StringBuffer sql = new StringBuffer();
	    sql.append(" select noticeno, wname, title, content, cnt, rdate ");
        sql.append(" from notice ");
        sql.append(" where noticeno = ?  ");
		
        try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno - 1);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pdto = new NoticeDTO();
				pdto.setNoticeno(rs.getInt("noticeno"));
				pdto.setWname(rs.getString("wname"));
				pdto.setTitle(rs.getString("title"));
				pdto.setCnt(rs.getInt("cnt"));
				pdto.setRdate(rs.getString("rdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return pdto;
	}
	
	public boolean update(NoticeDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
	    PreparedStatement pstmt = null;
	    
	    StringBuffer sql = new StringBuffer();
	    sql.append(" update notice ");
	    sql.append(" set wname = ? , ");
	    sql.append(" 	 title = ? , ");	    
	    sql.append(" 	 content = ?  ");	    
	    sql.append(" where noticeno = ? ");	    
		
	    try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
	        pstmt.setString(3, dto.getContent());
	        pstmt.setInt(4, dto.getNoticeno());
	        
	        int cnt = pstmt.executeUpdate();
	        if(cnt > 0) flag = true;
	        
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public boolean passCheck(Map map) {
		boolean flag = false;
		Connection con = DBOpen.open();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    int noticeno = (Integer)map.get("noticeno");
	    String passwd = (String)map.get("passwd");
	    
	    StringBuffer sql = new StringBuffer();
	    sql.append(" select count(noticeno) as cnt ");
	    sql.append(" from notice ");
	    sql.append(" where noticeno = ? and passwd = ? ");
	    
	    try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			rs.next();
			
			int cnt = rs.getInt("cnt");
			if(cnt > 0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return flag;
	}
	
	public boolean delete(int noticeno) {
		boolean flag = false;
		Connection con = DBOpen.open();
	    PreparedStatement pstmt = null;
	    
	    StringBuffer sql = new StringBuffer();
	    sql.append(" delete from notice ");
	    sql.append(" where noticeno = ? ");
	    
	    try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno);
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
}
