package com.ssafy.enjoytrip.plan.controller;

import com.ssafy.enjoytrip.member.model.entity.Member;
import com.ssafy.enjoytrip.member.model.service.MemberService;
import com.ssafy.enjoytrip.plan.model.dto.PlanDto;
import com.ssafy.enjoytrip.plan.model.service.PlanService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;

@Slf4j
@RequestMapping("/api/v1/plan")
@RestController
public class PlanController {

    private final PlanService planService;
    private final MemberService memberService;


    @Autowired
    public PlanController(PlanService planService, MemberService memberService) {
        this.planService = planService;
        this.memberService = memberService;
    }

    @GetMapping("/list")
    public ResponseEntity<List<PlanDto>> getList(@AuthenticationPrincipal Member member) throws SQLException {

        List<PlanDto> list = planService.getList(memberService.findByLoginId(member.getLoginId()).getId());

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @GetMapping("/view/{planId}")
    public ResponseEntity<PlanDto> view(@AuthenticationPrincipal Member member, @PathVariable("planId") long planId) throws SQLException {

        PlanDto planDto = new PlanDto();

        planDto = planService.view(planId);

        return new ResponseEntity<>(planDto, HttpStatus.OK);
    }

    @PutMapping("/modify")
    public ResponseEntity<?> update(@AuthenticationPrincipal Member member, @RequestBody PlanDto planDto) throws SQLException {

        planService.update(planDto);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @DeleteMapping("/delete/{planId}")
    public ResponseEntity<?> delete(@AuthenticationPrincipal Member member, @PathVariable("planId") long planId) throws SQLException {

        planService.delete(planId);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/write")
    public ResponseEntity<?> write(@AuthenticationPrincipal Member member, @RequestBody PlanDto planDto) throws SQLException {

        planDto.setMemberId(memberService.findByLoginId(member.getLoginId()).getId());

        log.info(planDto.toString());

        planService.write(planDto);

        return new ResponseEntity<>(HttpStatus.OK);
    }
}
